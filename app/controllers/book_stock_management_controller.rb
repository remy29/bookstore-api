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
    isbn = request.query_string.tr('=data', '')
    book = Book.find_by!(isbn: isbn)
    render json: book.to_json
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

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

  def update
    Book.find_by(isbn: params[:isbn])
  end

  def destroy
  end

  private

  def create_params
    params.permit(:title, :author, :isbn, :stock, :status)
  end
end
