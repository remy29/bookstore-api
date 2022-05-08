# frozen_string_literal: true

class BookStockManagementController < ApplicationController
  def index
    all_books = Book.all
    render json: all_books.to_json
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def show
    search_params = {}
    search_params[:isbn] = params[:isbn] if params[:isbn]
    search_params[:author] = params[:author] if params[:author]
    search_params[:title] = params[:title] if params[:title]
    search_params[:bookstore] = Bookstore.find_by!(name: params[:store]) if params[:store]
    books = Book.where(search_params)
    raise 'No entries found in database' if books.empty?

    render json: books.to_json
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def create
    stores_and_stocks = []
    store_added_to = []
    errors = []
    JSON.parse(params[:stores]).each do |store|
      new_book = Book.new(
        title: params[:title],
        author: params[:author],
        isbn: params[:isbn],
        stock: store['stock'],
        bookstore: Bookstore.find_by(name: store['name'])
      )
      if new_book.save
        stores_and_stocks.push("#{store['name']} (stock: #{store['stock']})")
        store_added_to.push(Bookstore.find_by(name: store['name']).id)
      else
        errors.push(
          error: new_book.errors,
          store: store['name']
        )
      end
    end
    raise errors.to_json if stores_and_stocks.empty?

    Bookstore.where.not(id: store_added_to).each do |store|
      store.add_book(
        params[:title],
        params[:author],
        params[:isbn]
      )
    end
    render json: {
      message: "#{params[:title]}, by #{params[:author]}, "\
                "with ISBN #{params[:isbn]} added to #{stores_and_stocks.join(', ')} ",
      errors: errors
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def update
    book = Book.find_by!(
      isbn: params[:isbn],
      bookstore: Bookstore.find_by!(name: params[:store])
    )
    book.update!(stock: params[:stock])
    message = "Stock updated to #{params[:stock]} for book with ISBN #{params[:isbn]} at #{params[:store]}"
    book.update_status(params[:stock]) && message += ", status updated to #{book.status}"
    render json: message
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def destroy
    isbn = params[:isbn]
    books = Book.where(isbn)
    raise "Couldn't find books" if books.empty?

    books.destroy_all
    render json: {
      message: "Books with ISBN #{isbn} removed from database"
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

end
