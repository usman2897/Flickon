require 'test_helper'

class ItemPropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_property = item_properties(:one)
  end

  test "should get index" do
    get item_properties_url
    assert_response :success
  end

  test "should get new" do
    get new_item_property_url
    assert_response :success
  end

  test "should create item_property" do
    assert_difference('ItemProperty.count') do
      post item_properties_url, params: { item_property: { item_property: @item_property.item_property, property_value: @item_property.property_value } }
    end

    assert_redirected_to item_property_url(ItemProperty.last)
  end

  test "should show item_property" do
    get item_property_url(@item_property)
    assert_response :success
  end

  test "should get edit" do
    get edit_item_property_url(@item_property)
    assert_response :success
  end

  test "should update item_property" do
    patch item_property_url(@item_property), params: { item_property: { item_property: @item_property.item_property, property_value: @item_property.property_value } }
    assert_redirected_to item_property_url(@item_property)
  end

  test "should destroy item_property" do
    assert_difference('ItemProperty.count', -1) do
      delete item_property_url(@item_property)
    end

    assert_redirected_to item_properties_url
  end
end
