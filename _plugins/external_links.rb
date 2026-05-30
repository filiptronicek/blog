# Opens external links in a new tab at build time, with no client-side JS.
#
# Internal links on this site are always written relative ("/path/", "#anchor"),
# while links off-site are absolute ("https://..."). So "external" simply means
# the href is an absolute http(s) URL. Relative paths, fragments, and
# mailto:/tel: links are left untouched.
#
# External anchors get target="_blank" plus rel="noopener noreferrer" (security:
# stops the opened page reaching back via window.opener, and drops the referrer).
# Links that already declare a target are left as-is.

ANCHOR_RE = %r{<a\b([^>]*?)\bhref="([^"]*)"([^>]*)>}i

# Absolute http(s) URL, e.g. https://example.com/path.
ABSOLUTE_HTTP_RE = %r{\Ahttps?://}i

def external_href?(href)
  return false if href.nil? || href.empty?

  href.match?(ABSOLUTE_HTTP_RE)
end

def merge_rel(attrs)
  needed = %w[noopener noreferrer]
  if attrs =~ /\brel="([^"]*)"/i
    existing = Regexp.last_match(1).split(/\s+/)
    merged = (existing + needed).uniq.join(" ")
    attrs.sub(/\brel="[^"]*"/i, %(rel="#{merged}"))
  else
    %(#{attrs} rel="#{needed.join(' ')}")
  end
end

def open_external_links(html)
  html.gsub(ANCHOR_RE) do
    pre  = Regexp.last_match(1)
    href = Regexp.last_match(2)
    post = Regexp.last_match(3)
    full = Regexp.last_match(0)

    # Leave links that already set a target.
    next full if (pre + post) =~ /\btarget="/i
    next full unless external_href?(href)

    attrs = merge_rel(pre + post).squeeze(" ").strip
    %(<a #{attrs} href="#{href}" target="_blank">)
  end
end

Jekyll::Hooks.register %i[pages documents], :post_render do |item|
  next unless item.output_ext == ".html"

  item.output = open_external_links(item.output)
end
