require 'test_helper'

class FirstnamesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get firstnames_edit_url
    assert_response :success
  end

end
