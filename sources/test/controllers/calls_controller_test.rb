require 'test_helper'

class CallsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calls_index_url
    assert_response :success
  end

end
