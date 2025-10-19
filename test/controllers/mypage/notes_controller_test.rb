require "test_helper"

class Mypage::NotesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mypage_notes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get mypage_notes_destroy_url
    assert_response :success
  end
end
