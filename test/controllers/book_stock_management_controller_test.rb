require 'test_helper'

class BookStockManagementControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_stock_management_index_url
    assert_response :success
  end

  test "should get show" do
    get book_stock_management_show_url
    assert_response :success
  end

  test "should get create" do
    get book_stock_management_create_url
    assert_response :success
  end

  test "should get update" do
    get book_stock_management_update_url
    assert_response :success
  end

  test "should get destroy" do
    get book_stock_management_destroy_url
    assert_response :success
  end

end
