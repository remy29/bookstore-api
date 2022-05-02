# frozen_string_literal: true
# HERE
# rename controller
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
    book = Book.find_by!(isbn: request.query_string.tr('=data', ''))
    render json: book.to_json
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end
  # HERE
  # make example request
  def create
    Book.create!(create_params)
    render json: {
      message: "#{params[:title]}, by #{params[:author]}, with ISBN #{params[:isbn]} saved to database with stock level: #{params[:stock]}"
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end
  # HERE
  # make example request
  def update
    isbn = request.query_string.tr('=data', '')
    book = Book.find_by!(isbn)
    book.update!(update_params)
    message = "#{update_params.keys} updated to #{update_params.values} for book with ISBN #{isbn}"
    book.update_status(update_params[:stock]) && message += ", Status updated to #{book.status}"
    render json: message
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def destroy
    isbn = request.query_string.tr('=data', '')
    book = Book.find_by!(isbn)
    book.destroy!
    render json: {
      message: "Book with ISBN #{isbn} destroyed"
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  private

  def update_params
    params.permit(:title, :author, :isbn, :stock)
  end

  def create_params
    params.permit(:title, :author, :isbn, :stock, :status)
  end
end
