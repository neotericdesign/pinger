# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'tabletastic', :version => '~>0.1.3'
  config.gem 'formtastic', :version => '~>0.9.7'
  config.gem 'validation_reflection'
  config.gem 'inherited_resources', :version => '~>1.0.1'
  config.gem 'hoptoad_notifier', :version => '~>2.2.0'
  config.gem 'will_paginate'
  config.gem 'curb', :version => '~>0.6.6.0'

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
end