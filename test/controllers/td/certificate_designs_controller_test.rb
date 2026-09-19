require "test_helper"

class Td::CertificateDesignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get td_certificate_designs_index_url
    assert_response :success
  end

  test "should get create" do
    get td_certificate_designs_create_url
    assert_response :success
  end
end
