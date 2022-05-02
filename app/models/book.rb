class Book < ApplicationRecord
  validate :check_isbn
  validates :isbn, uniqueness: true
  validates :author, presence: true
  validates :title, presence: true
  validates :status, presence: true
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum status: %i[in_stock low_on_stock out_of_stock]

  def update_status(new_stock)
    return unless new_stock

    if new_stock.zero?
      update(status: 'out_of_stock')
    elsif new_stock.positive? && new_stock < 4
      update(status: 'low_on_stock')
    elsif new_stock >= 4
      update(status: 'in_stock')
    else
      raise 'invalid stock update amount'
    end
  end

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
