require 'test_helper'

class UsersActivationTest < ActionDispatch::IntegrationTest
  def setup
    @activated_user = users(:michael)
    @not_activated_user = users(:lana)
  end

  test "only show activated user in index page" do
    log_in_as(@activated_user)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@activated_user), text: @activated_user.name
    assert_select 'a[href=?]', user_path(@not_activated_user), text: @not_activated_user.name, count: 0
  end

  test "only show activated user in show page" do
    log_in_as(@activated_user)
    get user_path(@not_activated_user)
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end

end
