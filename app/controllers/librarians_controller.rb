class LibrariansController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_librarian

  def dashboard
    @current_user = current_user
    @total_books = Book.count
    @total_borrowed_books = Borrowing.where(returned_at: nil).count
    @books_due_today = Borrowing.where(due_date: Date.today, returned_at: nil).count
    @members_with_overdue_books = User.joins(:borrowings).merge(Borrowing.overdue).distinct
    @recently_returned_books = Book.joins(:borrowings).merge(Borrowing.where.not(returned_at: nil)).order('borrowings.returned_at DESC').limit(10)
  end
  
  def logout
    sign_out(current_user)
    redirect_to root_path, notice: 'Logged out successfully.'
  end

  private

  def authorize_librarian
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.librarian?
  end
end