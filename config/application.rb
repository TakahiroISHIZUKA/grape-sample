require File.expand_path('../boot', __FILE__)

require 'rails/all'
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    
    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'views', 'apis'
    end
  end
end
