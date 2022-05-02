class BookStockManagementController < ApplicationController
  def index
  end

  def show
  end

  def create
    new_book = Book.new(create_params)

    raise new_book.errors.to_json unless new_book.save

    render json: {
      message: "#{params[:title]}, by #{params[:author]}, with ISBN #{params[:isbn]} saved to database with stock level: #{params[:stock]}"
    }
  rescue StandardError => e
    render json: {
      error: e
    }, status: :unprocessable_entity
  end

  def update
  end

  def destroy
  end

  private

  def create_params
    params.permit(:title, :author, :isbn, :stock, :status)
  end
end
