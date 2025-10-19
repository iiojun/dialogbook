require "test_helper"

class Td::MeetingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get td_meetings_new_url
    assert_response :success
  end

  test "should get index" do
    get td_meetings_index_url
    assert_response :success
  end

  test "should get create" do
    get td_meetings_create_url
    assert_response :success
  end

  test "should get edit" do
    get td_meetings_edit_url
    assert_response :success
  end

  test "should get update" do
    get td_meetings_update_url
    assert_response :success
  end

  test "should get destroy" do
    get td_meetings_destroy_url
    assert_response :success
  end
end
