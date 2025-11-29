require "test_helper"

class OrganizersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get organizers_show_url
    assert_response :success
  end
end
