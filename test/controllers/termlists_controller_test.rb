require 'test_helper'

class TermlistsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get termlists_show_url
    assert_response :success
  end

end
