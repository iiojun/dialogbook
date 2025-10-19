require "test_helper"

class Admin::SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_schools_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_schools_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get admin_schools_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_schools_update_url
    assert_response :success
  end
end
