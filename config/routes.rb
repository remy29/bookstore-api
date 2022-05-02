Rails.application.routes.draw do
  get 'book_stock_management/index'
  get 'book_stock_management/show'
  post 'book_stock_management/create'
  patch 'book_stock_management/update'
  delete 'book_stock_management/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
