require "test_helper"

class Mypage::ConsentFormVersionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypage_consent_form_versions_show_url
    assert_response :success
  end
end
