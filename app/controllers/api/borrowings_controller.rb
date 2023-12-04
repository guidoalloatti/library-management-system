class Api::BorrowingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_librarian #, except: [:return]
  
    def index
      borrowings = Borrowing.all
      render json: borrowings
    end
  
    def show
      borrowing = Borrowing.find_by_id(params[:id])

      if borrowing.nil?
        render json: { errors: "Record not found"}, status: :unprocessable_entity
      else
        render json: borrowing
      end
    end
  
    def create
      borrowing = Borrowing.new(borrowing_params.merge(due_date: 2.weeks.from_now))
  
      if borrowing.save
        render json: borrowing, status: :created
      else
        render json: { errors: borrowing.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      borrowing = Borrowing.find(params[:id])
      
      if borrowing.nil?
        render json: { errors: "Record not found"}, status: :unprocessable_entity
      elsif borrowing.update(borrowing_params)
        render json: borrowing
      else
        render json: { errors: borrowing.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      borrowing = Borrowing.find_by_id(params[:id])

      if borrowing.nil?
        render json: { errors: "Borrowing not found"}, status: :unprocessable_entity
      else
        borrowing.destroy
        render json: { message: "Borrowing successfuly deleted" }
      end
    end
  
    def return
      borrowing = Borrowing.find(params[:id])
      borrowing.returned_at = Time.now
  
      if borrowing.save
        render json: borrowing
      else
        render json: { errors: borrowing.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def borrowing_params
      params.require(:borrowing).permit(:user_id, :book_id, :borrowed_at, :returned_at, :due_date)
    end
  
    def authorize_librarian
      return if current_user.librarian?
  
      render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
    end
  end
  