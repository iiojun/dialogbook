require "test_helper"

class Td::CertificatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get td_certificates_index_url
    assert_response :success
  end
end
