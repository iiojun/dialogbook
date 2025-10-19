require "test_helper"

class Td::LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get td_lessons_new_url
    assert_response :success
  end

  test "should get index" do
    get td_lessons_index_url
    assert_response :success
  end

  test "should get create" do
    get td_lessons_create_url
    assert_response :success
  end

  test "should get edit" do
    get td_lessons_edit_url
    assert_response :success
  end

  test "should get update" do
    get td_lessons_update_url
    assert_response :success
  end

  test "should get destroy" do
    get td_lessons_destroy_url
    assert_response :success
  end
end
