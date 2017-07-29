module Metatron
  module ControllerConcerns
    extend ActiveSupport::Concern

    included do
      helper_method :metatron
      helper :'metatron/application'
    end

    def metatron(hash = {})
      _metatron_builder.assign(hash)
    end

    private

    def _metatron_builder
      @metatron_builder ||= Builder.new
    end
  end
end