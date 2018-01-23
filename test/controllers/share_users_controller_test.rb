require 'test_helper'

class ShareUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get share_users_new_url
    assert_response :success
  end

end
