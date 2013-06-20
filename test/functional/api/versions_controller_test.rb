require 'test_helper'

class Api::VersionsControllerTest < ActionController::TestCase
  test "should get last" do
    get :last
    assert_response :success
  end

end
