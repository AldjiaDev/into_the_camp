require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
  user = User.new(name: "Test User", password: "password", password_confirmation: "password")
  assert_not user.save, "Saved the user without an email"
  end
end
