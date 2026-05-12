require "test_helper"

class Td::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get td_todos_index_url
    assert_response :success
  end
end
