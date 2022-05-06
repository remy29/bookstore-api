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
    book = Book.find_by!(isbn: params[:isbn])
    render json: book.to_json
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def create
    Book.create!(create_params)
    render json: {
      message: "#{create_params[:title]}, by #{create_params[:author]},"\
               "with ISBN #{create_params[:isbn]} saved to database with stock level: #{create_params[:stock]}"
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def update
    isbn = params[:isbn]
    book = Book.find_by!(isbn)
    book.update!(update_params)
    message = "#{update_params.keys} updated to #{update_params.values} for book with ISBN #{isbn}"
    book.update_status(update_params[:stock]) && message += ", status updated to #{book.status}"
    render json: message
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def destroy
    isbn = params[:isbn]
    book = Book.find_by!(isbn)
    book.destroy!
    render json: {
      message: "Book with ISBN #{isbn} removed from dadsdsdsdtabase"
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
    params.permit(:title, :author, :isbn, :stock)
  end
end
