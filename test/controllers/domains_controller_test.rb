require "test_helper"

class DomainsControllerTest < ActionDispatch::IntegrationTest
  test "should get dns" do
    get domains_dns_url
    assert_response :success
  end

  test "should get email" do
    get domains_email_url
    assert_response :success
  end

  test "should get links" do
    get domains_links_url
    assert_response :success
  end

  test "should get settings" do
    get domains_settings_url
    assert_response :success
  end
end
