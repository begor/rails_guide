require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "should not create user" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new' # Re-renders
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count: 8
  end

  test "should create user" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  "John Doe",
                                         email: "valid@test.org",
                                         password: "foobar",
                                         password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
