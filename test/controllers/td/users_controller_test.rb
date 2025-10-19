require "test_helper"

class Td::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get td_users_index_url
    assert_response :success
  end

  test "should get edit" do
    get td_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get td_users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get td_users_destroy_url
    assert_response :success
  end
end
