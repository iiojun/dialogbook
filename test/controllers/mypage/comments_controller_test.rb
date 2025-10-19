require "test_helper"

class Mypage::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mypage_comments_create_url
    assert_response :success
  end
end
