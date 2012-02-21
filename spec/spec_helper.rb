require 'spork'  
  
Spork.prefork do  
  # Loading more in this block will cause your tests to run faster. However,  
  # if you change any configuration or code from libraries loaded here, you'll  
  # need to restart spork for it take effect.  
  
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.include(MailerMacros)
    config.before(:each) { reset_email }
    config.before(:each, :type => :request) do
   Capybara.run_server = true 
    Capybara.server_port = 3000 
    Capybara.app_host = "http://localhost:#{Capybara.server_port}" 
    end

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end

end  

Spork.each_run do
  FactoryGirl.reload
  NewBooks::Application.reload_routes!
end
