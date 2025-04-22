require "test_helper"

class Narrator::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get narrator_dashboard_index_url
    assert_response :success
  end
end
