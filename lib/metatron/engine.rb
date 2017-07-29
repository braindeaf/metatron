module Metatron
  class Engine < ::Rails::Engine
    # initializer 'metatron.configure_rails_initialization' do
    config.to_prepare do
      ApplicationController.include(Metatron::ControllerConcerns)
    end
  end
end