require 'test_helper'

class BookStockManagementControllerTest < ActionDispatch::IntegrationTest
  api_key = Rails.application.secrets.bookstore_api_key
  api_secret = Rails.application.secrets.bookstore_secret_key
  auth_headers = ActionController::HttpAuthentication::Basic.encode_credentials(api_key, api_secret)

  test 'should get index with authorized user' do
    get book_stock_management_index_url, headers: { Authorization: auth_headers }
    assert_response :success
  end

  test 'should return error with unauthorized user' do
    get book_stock_management_index_url
    assert_response :unauthorized
  end

  test 'should get show with book in database' do
    show_params = { 
      isbn: '123-466-789-122-1',
      store: "Big John's Big Books"
    }
    get book_stock_management_show_url, params: show_params, headers: { Authorization: auth_headers }
    assert_response :success
  end

  test 'should return show with book not in database' do
    show_params = { isbn: '123-466-789-122-5' }
    get book_stock_management_show_url, params: show_params, headers: { Authorization: auth_headers }
    assert_response :unprocessable_entity
  end

  test 'post create should create a new book with correct status' do
    create_params = {
      title: 'title3',
      author: 'author3',
      isbn: '123-466-789-182-1',
      stores: "[{\"name\":\"Books! Books? Books!\",\"stock\":5},{\"name\":\"Big John's Big Books\",\"stock\":1}]"
    }
    post book_stock_management_create_url, params: create_params, headers: { Authorization: auth_headers }
    assert_response :success
    assert_equal 'out_of_stock', Book.last.status
    assert_equal 7, Book.all.count
  end

  test 'post create return an error if isbn is improperly formatted' do
    create_params = {
      title: 'title3',
      author: 'author3',
      isbn: '123-466-789-182-1232324343434343',
      stores: "[{\"name\":\"Books! Books? Books!\",\"stock\":5},{\"name\":\"Big John's Big Books\",\"stock\":1}]"
    }
    post book_stock_management_create_url, params: create_params, headers: { Authorization: auth_headers }
    assert_response :unprocessable_entity
  end

  test 'post create return an error if params are missing' do
    create_params = {
      title: 'title3',
      author: 'author3',
      stores: "[{\"name\":\"Books! Books? Books!\",\"stock\":5},{\"name\":\"Big John's Big Books\",\"stock\":1}]"
    }
    post book_stock_management_create_url, params: create_params, headers: { Authorization: auth_headers }
    assert_response :unprocessable_entity
  end

  test 'patch update should return success and properly update status' do
    update_params = {
      store: 'Books! Books? Books!',
      isbn: '123-466-789-122-1',
      stock: 10
    }
    patch book_stock_management_update_url, params: update_params, headers: { Authorization: auth_headers }
    assert_response :success
    assert_equal 'in_stock', Book.find_by(isbn: '123-466-789-122-1').status
  end

  test 'should destroy book by isbn' do
    destroy_params = {
      isbn: '123-466-789-122-2'
    }
    delete book_stock_management_destroy_url, params: destroy_params, headers: { Authorization: auth_headers }
    assert_response :success
  end
end
