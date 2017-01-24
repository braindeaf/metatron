module Metatron
  class Railtie < Rails::Railtie
    initializer 'metatron.configure_rails_initialization' do
      ApplicationController.include(Metatron::ControllerConcerns)
    end
  end
end