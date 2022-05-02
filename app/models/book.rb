class Book < ApplicationRecord
  validate :check_isbn
  validates :isbn, uniqueness: true
  validates :author, presence: true
  validates :title, presence: true

  private

  def check_isbn
    # regex leaves only number and '-' chars
    only_valid_chars = isbn.tr("^[0-9-]*$", '') == isbn
    # regex leaves only number chars
    isbn_length = isbn.tr('^0-9', '').length
    unless [10, 13].include?(isbn_length)
      errors.add(:isbn, 'isbn must be either 10 or 13 digits long')
    end
    unless only_valid_chars
      errors.add(:isbn, "isbn must contain only numbers or '-'")
    end
  end
end
