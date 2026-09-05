require "test_helper"

class Mypage::ConsentFormsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypage_consent_forms_show_url
    assert_response :success
  end

  test "should get create" do
    get mypage_consent_forms_create_url
    assert_response :success
  end
end
