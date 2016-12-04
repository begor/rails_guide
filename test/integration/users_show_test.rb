require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @activated     = users(:archer)
    @non_activated = users(:malory)
  end

  test "show only activated" do
    get user_path(@activated)
    assert_template 'users/show'
    get user_path(@non_activated)
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
