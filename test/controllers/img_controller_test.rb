require 'test_helper'

class ImgControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get img_edit_url
    assert_response :success
  end

end
