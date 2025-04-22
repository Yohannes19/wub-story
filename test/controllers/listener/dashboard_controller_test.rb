require "test_helper"

class Listener::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get listener_dashboard_index_url
    assert_response :success
  end
end
