require "test_helper"

class Td::ConsentItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get td_consent_items_create_url
    assert_response :success
  end

  test "should get edit" do
    get td_consent_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get td_consent_items_update_url
    assert_response :success
  end

  test "should get delete" do
    get td_consent_items_delete_url
    assert_response :success
  end
end
