require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'neo4j/railtie'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Neo4jMovie
  class Application < Rails::Application
    config.generators { |g| g.orm :neo4j }
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.template_engine nil
      g.test_framework nil
      g.assets false
      g.helper false
      g.stylesheets false
    end
    config.neo4j.session.type = :http
    config.neo4j.session.url = 'http://neo4j:123@localhost:7474'
    config.neo4j.module_handling = :demodulize
    config.neo4j.skip_migration_check = true
  end
end
