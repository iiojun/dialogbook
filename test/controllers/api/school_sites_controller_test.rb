require "test_helper"

class Api::SchoolSitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_school_sites_index_url
    assert_response :success
  end
end
