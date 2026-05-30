# Adds Wikipedia-style hover/focus previews to footnote references at build
# time, with no client-side JavaScript.
#
# kramdown renders each reference as
#   <sup id="fnref:N"><a href="#fn:N" class="footnote" ...>N</a></sup>
# and each note as
#   <li id="fn:N"><p>... <a class="reversefootnote">↩</a></p></li>
#
# This hook copies the note's HTML into a hidden <span class="footnote-preview">
# inside the reference, and tethers it to the reference with a unique
# anchor-name / position-anchor pair. All show/hide and positioning is handled
# in CSS (see _sass/_article.scss), gated behind @supports (anchor-name) so
# browsers without anchor positioning simply keep the normal jump-to-note link.

# Collect note id -> inner HTML, ready to nest inside an inline <sup>.
#
# The preview lives inside a <sup>, which is phrasing content, so it must not
# contain block elements. kramdown wraps each note in <p> tags; we drop the
# leading/trailing <p> and turn any internal paragraph breaks into <br><br> so
# the result is valid phrasing content the parser won't hoist out of the <sup>.
def collect_footnotes(html)
  notes = {}
  html.scan(%r{<li id="(fn:[^"]+)">(.*?)</li>}m) do |id, inner|
    cleaned = inner
              .gsub(%r{<a\b[^>]*class="reversefootnote"[^>]*>.*?</a>}m, "")
              .strip
              .sub(/\A<p>/, "")          # drop opening paragraph tag
              .sub(%r{</p>\z}, "")       # drop closing paragraph tag
              .gsub(%r{</p>\s*<p>}m, "<br><br>") # internal breaks -> inline
              .strip
    notes[id] = cleaned
  end
  notes
end

# Turn an element id into a valid <dashed-ident> for anchor-name.
def anchor_name(id)
  "--" + id.gsub(/[^a-zA-Z0-9]+/, "-")
end

REF_RE = %r{<sup id="(fnref:[^"]+)">(<a href="#(fn:[^"]+)"[^>]*>.*?</a>)</sup>}m

def add_footnote_previews(html)
  notes = collect_footnotes(html)
  return html if notes.empty?

  html.gsub(REF_RE) do
    sup_id  = Regexp.last_match(1)
    anchor  = Regexp.last_match(2)
    note_id = Regexp.last_match(3)

    content = notes[note_id]
    next Regexp.last_match(0) unless content

    name = anchor_name(sup_id)

    preview = %(<span class="footnote-preview" role="tooltip" aria-hidden="true" ) +
              %(style="position-anchor:#{name}">#{content}</span>)

    %(<sup id="#{sup_id}" style="anchor-name:#{name}">#{anchor}#{preview}</sup>)
  end
end

Jekyll::Hooks.register %i[pages documents], :post_render do |item|
  next unless item.output_ext == ".html"

  item.output = add_footnote_previews(item.output)
end
