require 'test_helper'

class PlivoControllerTest < ActionDispatch::IntegrationTest
  test "should get foward" do
    get plivo_foward_url
    assert_response :success
  end

  test "should get direct" do
    get plivo_direct_url
    assert_response :success
  end

end
