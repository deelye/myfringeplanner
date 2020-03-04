require 'test_helper'

class PlannersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get planners_show_url
    assert_response :success
  end

  test "should get edit" do
    get planners_edit_url
    assert_response :success
  end

  test "should get create" do
    get planners_create_url
    assert_response :success
  end

end
