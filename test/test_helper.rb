ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end

  # Add more helper methods to be used by all tests here...
  # Shoulda::Matchers.configure do |config|
  #   config.integrate do |with|
  #     # Choose a test framework:
  #     # with.test_framework :rspec
  #     with.test_framework :minitest
  #     # with.test_framework :minitest_4
  #     # with.test_framework :test_unit

  #     # # Choose a library:
  #     # with.library :active_record
  #     # with.library :active_model
  #     # with.library :action_controller
  #     # Or, choose all of the above:
  #     with.library :rails
  #   end
  # end
end
