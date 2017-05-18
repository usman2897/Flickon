require 'test_helper'

class ItemProrertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_prorerty = item_prorerties(:one)
  end

  test "should get index" do
    get item_prorerties_url
    assert_response :success
  end

  test "should get new" do
    get new_item_prorerty_url
    assert_response :success
  end

  test "should create item_prorerty" do
    assert_difference('ItemProrerty.count') do
      post item_prorerties_url, params: { item_prorerty: { item_property: @item_prorerty.item_property, property_value: @item_prorerty.property_value } }
    end

    assert_redirected_to item_prorerty_url(ItemProrerty.last)
  end

  test "should show item_prorerty" do
    get item_prorerty_url(@item_prorerty)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_prorerty_url(@item_prorerty)
    assert_response :success
  end

  test "should update item_prorerty" do
    patch item_prorerty_url(@item_prorerty), params: { item_prorerty: { item_property: @item_prorerty.item_property, property_value: @item_prorerty.property_value } }
    assert_redirected_to item_prorerty_url(@item_prorerty)
  end

  test "should destroy item_prorerty" do
    assert_difference('ItemProrerty.count', -1) do
      delete item_prorerty_url(@item_prorerty)
    end

    assert_redirected_to item_prorerties_url
  end
end
