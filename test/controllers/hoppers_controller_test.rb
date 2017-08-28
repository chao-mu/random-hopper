require 'test_helper'

class HoppersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hopper = hoppers(:one)
  end

  test "should get index" do
    get hoppers_url
    assert_response :success
  end

  test "should get new" do
    get new_hopper_url
    assert_response :success
  end

  test "should create hopper" do
    assert_difference('Hopper.count') do
      post hoppers_url, params: { hopper: { title: @hopper.title, user_id: @hopper.user_id } }
    end

    assert_redirected_to hopper_url(Hopper.last)
  end

  test "should show hopper" do
    get hopper_url(@hopper)
    assert_response :success
  end

  test "should get edit" do
    get edit_hopper_url(@hopper)
    assert_response :success
  end

  test "should update hopper" do
    patch hopper_url(@hopper), params: { hopper: { title: @hopper.title, user_id: @hopper.user_id } }
    assert_redirected_to hopper_url(@hopper)
  end

  test "should destroy hopper" do
    assert_difference('Hopper.count', -1) do
      delete hopper_url(@hopper)
    end

    assert_redirected_to hoppers_url
  end
end
