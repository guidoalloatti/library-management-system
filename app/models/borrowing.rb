class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :borrowed_at, presence: true
  validates :due_date, presence: true

  validate :book_not_already_borrowed_by_user, on: :create

  scope :overdue, -> { where('due_date < ? AND returned_at IS NULL', Time.current) }
  scope :active, -> { where('borrowings.returned_at IS NULL') }


  def overdue?
    due_date < Time.current && returned_at.nil?
  end

  private

  def book_not_already_borrowed_by_user
    if user && user&.borrowings.active.exists?(book_id: book.id)
      errors.add(:base, 'You have already borrowed this book.')
    end
  end
end