class Book < ApplicationRecord
    validates :title, presence: true
    validates :author, presence: true
    validates :genre, presence: true
    validates :isbn, presence: true, uniqueness: true
    validates :total_copies, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
    has_many :borrowings, dependent: :destroy
  
    # Scope for searching books
    scope :search, ->(query) {
      where('title LIKE ? OR author LIKE ? OR genre LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
    }

    scope :available_for_borrow, -> { where('total_copies > ?', Borrowing.where(book_id: self.ids, returned_at: nil).count) }
    
    def currrently_borrowed
      borrowings.where(returned_at: nil).count
    end

    def all_time_borrowed
      borrowings.count
    end

    def available_copies
      total_copies - currrently_borrowed
    end
  end