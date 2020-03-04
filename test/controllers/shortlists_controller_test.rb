require 'test_helper'

class ShortlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shortlists_show_url
    assert_response :success
  end

end
