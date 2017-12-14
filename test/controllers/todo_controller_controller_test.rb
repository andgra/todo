require 'test_helper'

class TodoControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get todo_controller_Index_url
    assert_response :success
  end

end
