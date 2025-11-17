---
title: "How that ML-KEM is doing"
image: ciphertrails_4.webp
---

Hey all! Some time has passed already and I felt like giving you all an update about how the adoption of Encrypted Client Hello and ML-KEM is doing. There's not too much I need you tell in long sentences, so let's do bullet-points this time around instead:

## Post-quantum adoption

- today, close to 50% of human internet traffic that routes through Cloudflare is using ML-KEM or X25519Kyber768 (for HTTP3 traffic, this jumps to about 65%!) [^1]
- since last time, both Chrome and Firefox made the switch to the [now standardized ML-KEM](https://csrc.nist.gov/pubs/fips/203/final). If you're not into threat actors harvesting your pre-quantum Safari traffic, upgrade your software to `(mac|i|iPad|tv|watch|vision)OS` 26.
- OpenSSL 3.5.0 [shipped](https://github.com/openssl/openssl/releases/tag/openssl-3.5.0) with native support for ML-KEM
- from a dataset of 10 000 most popular domains according to Cloudflare Radar, about 52% of them connect using ML-KEM

## Encrypted Client Hello

- using ECH is now possible in `curl` when building from [DEfO's OpenSSL](https://github.com/defo-project/openssl) fork. Instructions are [on GitHub](https://github.com/sftcd/curl/blob/ECH-experimental/docs/ECH.md)
- even though Safari is [supportive of the idea of ECH](https://github.com/WebKit/standards-positions/issues/46#issuecomment-1334681742), the lack of first-party support of DOH in the browser is likely holding back any innovation on this front
- in Firefox, ECH's default enabled state can be tweaked by enterprises or parents using policies for content filtering
- the Russian government is taking an official stance against ECH, stating it's "circumventing restrictions on access to information"[^2] [[source](https://portal.noc.gov.ru/ru/news/2024/11/07/%D1%80%D0%B5%D0%BA%D0%BE%D0%BC%D0%B5%D0%BD%D0%B4%D1%83%D0%B5%D0%BC-%D0%BE%D1%82%D0%BA%D0%B0%D0%B7%D0%B0%D1%82%D1%8C%D1%81%D1%8F-%D0%BE%D1%82-cdn-%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D0%B0-cloudflare/)]
- in June, we've gotten our 25th revision of the [ECH draft](https://datatracker.ietf.org/doc/draft-ietf-tls-esni/), with reports pointing to an upcoming official RFC publication – is this perhaps the motivation that the Safari team needed? [[source](https://www.feistyduck.com/newsletter/issue_127_encrypted_client_hello_approved_for_publication)]
- from the same dataset of 10 000 most popular domains, only about 5,4% offered and accepted an ECH connection

## Footnotes

[^1]: Data from [Cloudflare Radar](https://radar.cloudflare.com/explorer?dataSet=http&groupBy=post_quantum&filters=botClass%253DLikely_Human&dt=1d)
[^2]: And even worse, they miscapitalized Cloudflare in the official statement :\(
