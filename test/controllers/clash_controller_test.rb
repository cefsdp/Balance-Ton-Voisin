require 'test_helper'

class ClashControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get clash_new_url
    assert_response :success
  end

  test "should get create" do
    get clash_create_url
    assert_response :success
  end

  test "should get index" do
    get clash_index_url
    assert_response :success
  end

end
