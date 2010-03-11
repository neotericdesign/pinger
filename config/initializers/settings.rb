require 'ostruct'
require 'yaml'

config = YAML.load_file("#{Rails.root}/config/settings.yml") || {}
app_config = config[Rails.env] || {}

AppConfig = OpenStruct.new(app_config)
