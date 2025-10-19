require "test_helper"

class Td::SchoolsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get td_schools_show_url
    assert_response :success
  end
end
