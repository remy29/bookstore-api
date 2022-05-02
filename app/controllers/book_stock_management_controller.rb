class BookStockManagementController < ApplicationController
  def index
  end

  def show
  end

  def create
    new_book = Book.new(create_params)
    unless new_book.save
      render json: {
        error: new_book.errors.messages
      }, status: :bad_request
      return
    end
    render json: {
      message: "#{params[:title]}, by #{params[:author]}, with ISBN #{params[:isbn]} saved to database"
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
    params.permit(:title, :author, :isbn)
  end
end
