# Adds GitHub-style permalink anchors to article headings at build time.
#
# kramdown already assigns an `id` to every heading. This hook wraps the
# heading's inner content in an <a class="heading-anchor"> pointing at that id,
# so the whole heading becomes clickable and a link icon can be revealed on
# hover via CSS. No client-side JavaScript required.

LINK_ICON = <<~SVG.gsub(/\s*\n\s*/, " ").strip
  <svg class="octicon heading-anchor-icon" width="16" height="16"
    viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
    <path d="M7.775 3.275a.75.75 0 0 0 1.06 1.06l1.25-1.25a2 2 0 1 1
    2.83 2.83l-2.5 2.5a2 2 0 0 1-2.83 0 .75.75 0 0 0-1.06 1.06 3.5
    3.5 0 0 0 4.95 0l2.5-2.5a3.5 3.5 0 0 0-4.95-4.95l-1.25 1.25Zm-4.69
    9.64a2 2 0 0 1 0-2.83l2.5-2.5a2 2 0 0 1 2.83 0 .75.75 0 0 0
    1.06-1.06 3.5 3.5 0 0 0-4.95 0l-2.5 2.5a3.5 3.5 0 0 0 4.95
    4.95l1.25-1.25a.75.75 0 0 0-1.06-1.06l-1.25 1.25a2 2 0 0 1-2.83 0Z">
    </path>
  </svg>
SVG

# Match <h2>..<h6> that carry an id attribute, capturing the level, the full
# opening-tag attributes, and the inner HTML.
HEADING_RE = %r{<(h[2-6])\b([^>]*\bid="([^"]+)"[^>]*)>(.*?)</\1>}m

def add_heading_anchors(html)
  html.gsub(HEADING_RE) do
    tag   = Regexp.last_match(1)
    attrs = Regexp.last_match(2)
    id    = Regexp.last_match(3)
    inner = Regexp.last_match(4)

    # Skip if we've already processed this heading.
    next Regexp.last_match(0) if inner.include?('class="heading-anchor"')

    anchor = %(<a class="heading-anchor" href="##{id}" ) +
             %(aria-label="Permalink to this section">#{inner}#{LINK_ICON}</a>)

    %(<#{tag}#{attrs}>#{anchor}</#{tag}>)
  end
end

Jekyll::Hooks.register %i[pages documents], :post_render do |item|
  next unless item.output_ext == ".html"

  item.output = add_heading_anchors(item.output)
end
