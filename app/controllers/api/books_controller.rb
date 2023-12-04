class Api::BooksController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :authorize_librarian, only: [:create, :update, :destroy]
  
    def index
      books = Book.all
      render json: books
    end
  
    def show
      book = Book.find(params[:id])
      render json: book
    end
  
    def create
      book = Book.new(book_params)
  
      if book.save
        render json: book, status: :created
      else
        render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      book = Book.find(params[:id])
  
      if book.update(book_params)
        render json: book
      else
        render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      book = Book.find(params[:id])
      book.destroy
      head :no_content
    end
  
    def search
      title = params[:title]
      author = params[:author]
      genre = params[:genre]
  
      books = Book.all
  
      books = books.where('title ILIKE ?', "%#{title}%") if title.present?
      books = books.where('author ILIKE ?', "%#{author}%") if author.present?
      books = books.where('genre ILIKE ?', "%#{genre}%") if genre.present?
  
      render json: books
    end

    private
  
    def book_params
      params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
    end
  
    def authorize_librarian
      return if current_user.librarian?
  
      render json: { error: 'You are not authorized to perform this action.' }, status: :unauthorized
    end
  end
  