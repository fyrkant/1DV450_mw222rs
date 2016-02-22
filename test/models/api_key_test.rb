require "test_helper"

class ApiKeyTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should belong_to :user
end
