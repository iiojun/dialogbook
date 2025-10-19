require "test_helper"

class Mypage::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypage_users_show_url
    assert_response :success
  end

  test "should get update" do
    get mypage_users_update_url
    assert_response :success
  end
end
