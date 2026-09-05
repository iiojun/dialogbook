require "test_helper"

class Td::ConsentFormControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get td_consent_form_edit_url
    assert_response :success
  end

  test "should get show" do
    get td_consent_form_show_url
    assert_response :success
  end

  test "should get create" do
    get td_consent_form_create_url
    assert_response :success
  end

  test "should get destroy" do
    get td_consent_form_destroy_url
    assert_response :success
  end

  test "should get update" do
    get td_consent_form_update_url
    assert_response :success
  end
end
