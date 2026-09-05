require "test_helper"

class Mypage::UserConsentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mypage_user_consents_create_url
    assert_response :success
  end
end
