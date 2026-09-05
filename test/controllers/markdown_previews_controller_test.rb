require "test_helper"

class MarkdownPreviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get preview" do
    get markdown_previews_preview_url
    assert_response :success
  end
end
