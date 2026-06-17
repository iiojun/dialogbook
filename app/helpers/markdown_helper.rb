require "commonmarker"

module MarkdownHelper
  def markdown(text, p_class: nil)
    html = Commonmarker.to_html(text || "")
    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    if p_class.present?
      doc.css("p").each do |p|
        p["class"] = [p["class"], p_class].compact.join(" ")
      end
    end

    sanitize(
      doc.to_html,
      tags: %w[p br strong em a code pre h1 h2 h3 h4 ul ol li blockquote hr],
      attributes: %w[href class]
    )
  end
end
