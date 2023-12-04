class BorrowingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_book, only: [:create]
    before_action :set_borrowing, only: [:return]
  
    def create       
      if current_user.member? && @book.available_copies.positive?
        @borrowing = current_user.borrowings.new(book: @book, borrowed_at: Time.current, due_date: 2.weeks.from_now)
  
        if @borrowing.save
          redirect_to member_dashboard_path, notice: 'Book successfully borrowed.'
        else
          redirect_to member_dashboard_path, alert: "You are currently borrowing #{@book.title}. Please return this title and borrow it again."
        end
      else
        redirect_to member_dashboard_path, alert: 'The book is not available for borrowing.'
      end
    end
    
    def return
      @borrowing = Borrowing.find(params[:id])
      
      if @borrowing.update(returned_at: Time.now)
        redirect_to member_dashboard_path, notice: 'Book returned successfully.'
      else
        redirect_to member_dashboard_path, alert: 'Failed to return the book.'
      end
    end
  
    private
  
    def set_book
      @book = Book.find(params[:borrowing][:book_id])
    end
  
    def set_borrowing
      @borrowing = Borrowing.find(params[:id])
    end
  end