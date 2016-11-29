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
end
