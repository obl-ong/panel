require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get auth" do
    get users_auth_url
    assert_response :success
  end
end
