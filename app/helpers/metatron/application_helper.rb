module Metatron
  module ApplicationHelper
    def header_tags
      [        
        metatron_tags
      ].join("\n").html_safe
    end

    def metatron_tags
      [
        meta_tag(property: 'fb:app_id', content: '1434650413476851'),
        meta_tag(name: 'twitter:card', content: 'summary_large_image'),
        meta_tag(name: 'twitter:site', content: '@IPlayRedGaming'),
        meta_tag(name: 'twitter:creator', content: '@IPlayRedGaming'),
        meta_tag(property: 'og:type', content: 'website'),
        meta_tag(property: 'og:site_name', content: 'I Play Red'),
        meta_tag(property: 'og:url', content: url),
        tag(:link, rel: 'canonical', href: url),
        title_tags,
        description_tags,
        image_tags,
        keywords_tags,
      ].flatten.compact.join("\n").html_safe
    end

    def keywords_tags
      return [] unless (keywords).present?
      [
        meta_tag(name: 'keywords', content: keywords),
      ]
    end

    def image_tags
      return [] unless metatron.image
      [
        meta_tag(property: 'og:image', content: metatron.image),
        meta_tag(name: 'twitter:image:src', content: metatron.image)
      ]
    end

    def description_tags
      [
        meta_tag(name: 'description', content: metatron.description),
        meta_tag(property: 'og:description', content: metatron.description),
        meta_tag(name: 'twitter:description', content: metatron.description)
      ]
    end

    def title_tags
      [
        content_tag(:title, metatron.title),
        meta_tag(name: 'title', content: metatron.title),
        meta_tag(property: 'og:title', content: metatron.title),
        meta_tag(name: 'twitter:title', content: metatron.title)
      ]
    end

    private

    def keywords
      @keywords ||= begin

        Array[metatron.keywords, I18n.t('meta.keywords', default: '')].flatten.select(&:present?).map do |section|
          section.to_s.split(',')
        end.flatten.select(&:present?).map(&:strip).uniq.join(', ')
      end
    end

    def url
      (metatron.url || request.url).split('?')[0]
    end

    def meta_tag(options)
      tag(:meta, options)
    end
  end
end