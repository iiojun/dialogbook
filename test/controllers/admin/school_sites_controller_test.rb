require "test_helper"

class Admin::SchoolSitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_school_sites_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_school_sites_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_school_sites_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_school_sites_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_school_sites_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_school_sites_destroy_url
    assert_response :success
  end
end
