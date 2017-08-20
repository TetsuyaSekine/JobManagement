require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JobManagement
  class JobManagementplication < Rails::JobManagementplication
    # Settings in config/environments/* take precedence over those specified here.
    # JobManagementplication configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
