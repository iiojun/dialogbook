require "test_helper"

class Td::Api::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get td_api_users_index_url
    assert_response :success
  end
end
