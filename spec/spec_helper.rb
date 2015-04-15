require 'simplecov'
SimpleCov.start do
  # don't do coverage of our testing code
  add_filter '/spec/'
  # don't do coverage of our rake tasks
  add_filter '/lib/tasks/'
end

require 'rubygems'


ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.include(MailerMacros)
  config.before(:each) { reset_email }

  # Specify an alternative JS driver if we want to avoid selinium
  Capybara.javascript_driver = :webkit
  # Capybara.javascript_driver = :webkit_debug

  # http://www.elabs.se/blog/60-introducing-capybara-2-1
  # But try to rewrite our specs so that we don't have to change
  # Capybara's default configuration settings.
  # Capybara.configure do |config|
    # config.match = :one
    # config.exact_options = true
    # config.ignore_hidden_elements = true
    # config.visible_text_only = true
  # end

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # http://stackoverflow.com/questions/3333743
  # factory_girl + rspec doesn't seem to roll back changes after each example
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false

  # http://stackoverflow.com/questions/15307742
  # http://stackoverflow.com/questions/14881011
  # http://devblog.avdi.org/2012/08/31/configuring-database_cleaner
  # rspec with Capybara with :js => true runs multiple threads against SQLlite,
  # needs to run non-transactionally to avoid
  # "SQLite3::BusyException: database is locked"
  config.use_transactional_fixtures = false


  # capybara-webkit v1.4 began warning about every external URL.
  # Turn off warnings by blocking or allowing.
  # Do it here, so we don't have to add code to every spec file.
  # Here's one group's experience related to this:
  # http://robots.thoughtbot.com/speed-up-javascript-capybara-specs-by-blacklisting-urls
  config.before(:each, js: true) do

    # These are some of the external URLs our app hits.
    # These can be copied in as-needed for the tests that require them.

    # page.driver.allow_url("catalog.hathitrust.org")
    # page.driver.allow_url("books.google.com")
    # page.driver.allow_url(APP_CONFIG['clio_backend_url'])

    # ??? We're getting capybara webkit failures unless this is allowed?
    page.driver.allow_url("www.google-analytics.com")

    page.driver.block_unknown_urls

    # this syntax might also be available
    # page.driver.browser.url_blacklist = ["http://use.typekit.net"]

    # # # Capybara URL whitelisting
    #  config.before(:each) do
    #      puts "AAA"
    #      if page.present? && page.driver.respond_to?(:block_unknown_urls)
    #        puts "BBB"
    #        page.driver.block_unknown_urls
    #      end
    #      # if page && page.driver.respond_to?(:allow_url)
    #      #   page.driver.allow_url("catalog.hathitrust.org")
    #      #   page.driver.allow_url("books.google.com")
    #      #   page.driver.allow_url("http://bronte.cul.columbia.edu/clio_backend_dev")
    #      # end
    #  end

    # from https://github.com/thoughtbot/capybara-webkit/issues/717
    # config.before :each, :js, type: :feature do |example|

    config.before(:each, js: true) do
      # Everything is terrible. js: true in config.before will run if the js tag
      # is present in the spec declaration, regardless of the value.
      page.driver.block_unknown_urls
      page.driver.allow_url("catalog.hathitrust.org")
      page.driver.allow_url("books.google.com")
      page.driver.allow_url("http://bronte.cul.columbia.edu/clio_backend_dev")
    end


  end

end

