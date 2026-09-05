require "test_helper"

class Td::ConsentFormVersionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get td_consent_form_versions_new_url
    assert_response :success
  end

  test "should get create" do
    get td_consent_form_versions_create_url
    assert_response :success
  end

  test "should get show" do
    get td_consent_form_versions_show_url
    assert_response :success
  end
end
