---
title: "Go 1.23 adds support for ECH and Kyber"
image: "go1.23.jpg"
---

Go 1.23 [is out](https://go.dev/blog/go1.23) and it brings many new features. In the beginning of the release notes there's a bunch to read about the range over function iterators functionality or the new `unique`, `structs` and `iter` packages, but given the fact I'm no go expert, I won't go into any of those.

The thing that stuck out to me were the changes to `crypto/tls`, which this time around were quite fruitful:

## <abbr title="Encrypted Client Hello">ECH</abbr>

Starting with this release, Go adds support for client-side ECH, which is a great step forward with potential adoption. Before its inclusion in the standard library, one would have to use third-party options, such as a custom library for making network requests or a custom build of Go (such as [cloudflare/go](https://github.com/cloudflare/go)). Having it in the standard library also means we're one step closer to [support with Caddy](https://github.com/caddyserver/caddy/issues/4221).

A simple example which checks if a website supports ECH could look like this:

```go
package main

import (
    "crypto/tls"
    "fmt"
    "net/http"
    "time"
)

func main() {
    domain := "crypto.cloudflare.com"
    req, err := http.NewRequest(
        "GET",
        "https://"+domain,
        nil,
    )
    if err != nil {
        return
    }

    http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{
        EncryptedClientHelloConfigList: echConfigList,
    }

    resp, err := (&http.Client{Timeout: 5 * time.Second}).Do(req)
    if err != nil {
        fmt.Println("ECH support: ", resp.TLS.ECHAccepted)
    }
}
```

Alright, let's just run this and...

```
undefined: echConfigListBytes
```

Damn it, we need some `EncryptedClientHelloConfigList` to let the client know about the public key with which to encrypt the <abbr title="Server Name Indication">SNI</abbr>. But how do we get that? Well, if you by chance stumbled upon [RFC 9460](https://datatracker.ietf.org/doc/rfc9460/) section 14.3.2 you could read that the DNS record type 65 (HTTPS) has a field called `ech`, which contains just that: the key to give to `EncryptedClientHelloConfigList` - yay! This means that to make a proper ECH-enabled HTTP request, we need to first query DNS, parse the response, and then use the key to give to `http.Client.Do`.

Knowing this, we can now write a more complete example:

```go
package main

import (
    "crypto/tls"
    "encoding/base64"
    "fmt"
    "log/slog"
    "net"
    "net/http"
    "regexp"
    "time"

    "github.com/miekg/dns"
)

// extractECH extracts the ECH value from the input string using regular expressions.
func extractECH(input string) (string, error) {
    re := regexp.MustCompile(`ech="([^"]+)"`)
    matches := re.FindStringSubmatch(input)
    if len(matches) < 2 {
        return "", fmt.Errorf("ech value not found")
    }
    return matches[1], nil
}

func main() {
    domain := "crypto.cloudflare.com"
    req, err := http.NewRequest(
        "GET",
        "https://"+domain,
        nil,
    )
    if err != nil {
        fmt.Printf("Error: %s\n", err)
    }

    config, _ := dns.ClientConfigFromFile("/etc/resolv.conf")
    c := new(dns.Client)

    existsMsg := new(dns.Msg)
    existsMsg.SetQuestion(dns.Fqdn(domain), dns.TypeA)
    existsMsg.RecursionDesired = true

    _, _, err = c.Exchange(existsMsg, net.JoinHostPort(config.Servers[0], config.Port))
    if err != nil {
        fmt.Printf("Error: %s\n", err)
    }

    m := new(dns.Msg)
    m.SetQuestion(dns.Fqdn(domain), dns.TypeHTTPS)
    m.RecursionDesired = true

    var echConfigListBytes []byte

    r, _, err := c.Exchange(m, net.JoinHostPort(config.Servers[0], config.Port))
    if r == nil {
        slog.Warn("DNS: error: %s\n", err.Error())
    } else if r.Rcode != dns.RcodeSuccess {
        slog.Warn("DNS: invalid answer name %s after MX query for %s\n", domain, domain)
    } else {
        for _, a := range r.Answer {
            if a.Header().Rrtype == dns.TypeHTTPS {
                echConfigListBase64, err := extractECH(a.String())
                if err != nil {
                    slog.Debug("Failed to extract ECH value", "err", err)
                    break
                }

                slog.Debug("ECH Value:", echConfigListBase64)
                echConfigListBytes, err = base64.StdEncoding.DecodeString(echConfigListBase64)
                if err != nil {
                    slog.Error("Failed to decode ECH config", "err", err)
                    break
                }

                break
            }
        }
    }

    http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{
        EncryptedClientHelloConfigList: echConfigListBytes,
    }

    resp, err := (&http.Client{Timeout: 5 * time.Second}).Do(req)
    if err != nil {
        fmt.Printf("Error: %s\n", err)
    }

    if resp.TLS.ECHAccepted {
        fmt.Printf("Domain %s supports ECH\n", domain)
    } else {
        fmt.Printf("Domain %s does not support ECH\n", domain)
    }
}
```

Wow, this got lengthy. Did it pay off? Let's see:

```sh
$ go run main.go
Domain crypto.cloudflare.com supports ECH
```

Nice. Online privacy achieved. What's next?

## Kyber

The other big addition to `crypto/tls` this time around is the support for the first post-quantum key exchange curve: X25519Kyber768Draft00. This key exchange is used by default when no `CurvePreferences` are set and you can specify it explicitly if you want to force its use.

```go
const (
    x25519Kyber768Draft00 tls.CurveID = 0x6399 // X25519Kyber768Draft00
)

http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{
    EncryptedClientHelloConfigList: echConfigListBytes,
    CurvePreferences:               []tls.CurveID{x25519Kyber768Draft00},
}
```

As you can see from the example above, the kyber curve is not exported from `crypto/tls` like the other curves, so we have to define it ourselves.

That's good and all, but the only thing this gives us is the binary ability to see whether the server accepts the kyber curve or not — the request will simply fail with `remote error: tls: illegal parameter`. It would be super great if there was an actual way to determine the negotiated key exchange group, but unfortunately that's behind an internal `tls.ConnectionState.testingOnlyCurveID`. For now, the best way to get this information is still to use Cloudflare's Go fork.

Alright, coool, awesome, bingo, huzzah, this is all very exciting. I guess, if you take anything from this post, let it be that Go 1.23 is worth upgrading to (and not just because the version string is ordered in ascending order). In fact, it's [already enabled](https://github.com/gitpod-io/workspace-images/pull/1403) by default in any new Gitpod workspace based on gitpod-provided workspace images.

Thumnail is [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) Renée French. I am very sorry for what I've done to the little gopher.
