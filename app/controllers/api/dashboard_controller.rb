class Api::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user
    
    def index
      @current_user = current_user
      current_user.role == "member" ? member_dashboard : librarian_dashboard
    end

    def member_dashboard
      @borrowed_books = current_user.borrowings.where(returned_at: nil)
      @due_books = current_user.borrowings.where('due_date < ? AND returned_at IS NULL', Time.current)
      @recently_returned_books = current_user.borrowings.where.not(returned_at: nil).order('borrowings.returned_at DESC').limit(10)

      render json: {
        dashboard_for_user: @current_user.email,
        request_role: @current_user.role,
        borrowed_books: @borrowed_books,
        due_books: @due_books,
        recently_returned_books: @recently_returned_books
      }
    end

    def librarian_dashboard
      @total_books = Book.count
      @total_borrowed_books = Borrowing.where(returned_at: nil).count
      @books_due_today = Borrowing.where(due_date: Date.today, returned_at: nil).count
      @members_with_overdue_books = User.joins(:borrowings).merge(Borrowing.overdue).distinct
      @recently_returned_books = Book.joins(:borrowings).merge(Borrowing.where.not(returned_at: nil)).order('borrowings.returned_at DESC').limit(10)

      render json: {
        dashboard_for_user: @current_user.email,
        request_role: @current_user.role,
        total_books: @total_books,
        total_borrowed_books: @total_borrowed_books,
        books_due_today: @books_due_today,
        members_with_overdue_books: @members_with_overdue_books,
        recently_returned_books: @recently_returned_books,
      }
    end

    def logout
      sign_out(current_user)
      redirect_to root_path, notice: 'Logged out successfully.'
    end

    private
  
    def authorize_user
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.member? || current_user.librarian?
    end
  end
