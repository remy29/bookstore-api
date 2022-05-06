class Book < ApplicationRecord
  validate :check_isbn
  validates :isbn, uniqueness: true
  validates :author, presence: true
  validates :title, presence: true
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum status: %i[in_stock low_on_stock out_of_stock]

  before_create :set_initial_status

  def update_status(new_stock)
    return unless new_stock

    new_status = stock_to_status(new_stock.to_i)

    return if status == new_status

    update!(status: new_status)
  end

  private

  def stock_to_status(stock)
    if stock.zero?
      'out_of_stock'
    elsif stock.positive? && stock < 4
      'low_on_stock'
    elsif stock >= 4
      'in_stock'
    else
      raise 'invalid stock amount'
    end
  end

  def set_initial_status
    self.status = stock_to_status(stock.to_i)
  end

  def check_isbn
    # regex leaves only number and '-' chars
    only_valid_chars = isbn.tr('^[0-9-]*$', '') == isbn
    # regex leaves only number chars
    isbn_length = isbn.tr('^0-9', '').length
    errors.add(:isbn, 'isbn must be either 10 or 13 digits long') unless [10, 13].include?(isbn_length)
    errors.add(:isbn, "isbn must contain only numbers or '-'") unless only_valid_chars
  end
end
