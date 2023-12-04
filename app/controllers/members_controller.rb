class MembersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_member
    
    def dashboard
      @current_user = current_user
      @borrowed_books = current_user.borrowings.where(returned_at: nil)
      @due_books = current_user.borrowings.where('due_date < ? AND returned_at IS NULL', Time.current)
      @recently_returned_books = current_user.borrowings.where.not(returned_at: nil).order('borrowings.returned_at DESC').limit(10)
    end

    def logout
      sign_out(current_user)
      redirect_to root_path, notice: 'Logged out successfully.'
    end

    private
  
    def authorize_member
      redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.member?
    end
  end