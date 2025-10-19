require "test_helper"

class Mypage::SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get mypage_schools_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mypage_schools_destroy_url
    assert_response :success
  end
end
