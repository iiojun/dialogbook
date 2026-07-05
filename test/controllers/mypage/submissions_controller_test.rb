require "test_helper"

class Mypage::SubmissionsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get mypage_submissions_update_url
    assert_response :success
  end
end
