require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'spec/autorun'
  require 'spec/rails'
  require 'remarkable_rails'
  require 'email_spec'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir.glob(File.dirname(__FILE__)+'/support/**/*.rb').each {|f| require f}

  Spec::Runner.configure do |config|
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
    config.mock_with :mocha
    config.ignore_backtrace_patterns(/spork/)
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
  end

  def stub_remote_activity
    Curl::Easy.any_instance.stubs(:perform).returns(true)
    Curl::Easy.any_instance.stubs(:body_str).returns("Response Body")
    Curl::Easy.any_instance.stubs(:response_code).returns(200)
  end

end

Spork.each_run do
  # This code will be run each time you run your specs.
end
