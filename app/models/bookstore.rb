class Bookstore < ApplicationRecord
  has_many :books

  def add_book(title, author, isbn)
    Book.create!(
      title: title,
      author: author,
      isbn: isbn,
      stock: 0,
      bookstore: self
    )
  end
end
