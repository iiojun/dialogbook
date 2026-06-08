require "test_helper"

class Admin::CertificatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_certificates_index_url
    assert_response :success
  end
end
