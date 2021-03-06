module Metatron
  module ApplicationHelper
    def header_tags
      [
        metatron_tags
      ].join("\n").html_safe
    end

    def metatron_tags
      [
        meta_tag(property: 'fb:app_id', content: metatron.fb_app_id || '1434650413476851'),
        twitter_card,
        meta_tag(name: 'twitter:site', content: metatron.twitter),
        meta_tag(name: 'twitter:creator', content: metatron.twitter),
        meta_tag(property: 'og:type', content: metatron.type || 'website'),
        meta_tag(property: 'og:site_name', content: site_name),
        meta_tag(property: 'og:url', content: url),
        tag(:link, rel: 'canonical', href: url),
        title_tags,
        description_tags,
        player_tags,
        image_tags,
        video_tags,
        keywords_tags,
      ].flatten.compact.join("\n").html_safe
    end

    def twitter_card
      card = metatron.player.present? ? 'player' : 'summary_large_image'
      meta_tag(name: 'twitter:card', content: card)
    end

    def player_tags
      return [] unless (metatron.player).present?
      [
        meta_tag(name: 'twitter:player', content: metatron.player),
        meta_tag(name: 'twitter:player:width', content: '1280'),
        meta_tag(name: 'twitter:player:height', content: '720')
      ]
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

    def video_tags
      return [] unless metatron.video
      [
        meta_tag(property: 'og:video:url', content: metatron.video),
        meta_tag(property: 'og:video:secure_url', content: metatron.video),
        meta_tag(property: 'og:video:width', content: metatron.video_width),
        meta_tag(property: 'og:video:height', content: metatron.video_height),
        meta_tag(property: 'og:video:type', content: metatron.video_type),
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
      t = [metatron.title, metatron.title_segment]
      t << site_name unless metatron.title.to_s.include?(site_name)

      if suffix = t('title_suffix', default: nil)
        t << suffix
      end

      [
        content_tag(:title, t.compact.uniq.join(' | ')),
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

    def site_name
      metatron.site_name || t('site_name')
    end

    def url
      (metatron.url || request.url).split('?')[0]
    end

    def meta_tag(options)
      tag(:meta, options)
    end
  end
end
