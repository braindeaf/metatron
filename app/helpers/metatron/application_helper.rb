module Metatron
  module ApplicationHelper
    def header_tags
      [
        content_tag(:title, metatron.title),
        metatron_tags
      ].join("\n").html_safe
    end

    def metatron_tags
      [
        meta_tag(property: 'og:type', content: 'website'),
        meta_tag(property: 'og:site_name', content: 'I Play Red'),
        meta_tag(property: 'og:url', content: request.url),
        meta_tag(name: 'title', content: metatron.title),
        meta_tag(property: 'og:title', content: metatron.title),
        meta_tag(name: 'description', content: metatron.description),
        meta_tag(property: 'og:description', content: metatron.description),
        metatron.image ? meta_tag(property: 'og:image', content: metatron.image) : nil
      ].compact.join("\n").html_safe
    end

    def meta_tag(options)
      tag(:meta, options)
    end
  end
end