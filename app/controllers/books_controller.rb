class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_librarian, except: [:index, :show]

  def index
    @current_user = current_user
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end
  
  def remove_book
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path, notice: 'Book was successfully deleted.'
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  def borrowings
    @book = Book.find(params[:book_id])
    @borrowings = @book.borrowings
  end

  def search
    title = params[:title]
    author = params[:author]
    genre = params[:genre]

    books = Book.all

    books = books.where('title ILIKE ?', "%#{title}%") if title.present?
    books = books.where('author ILIKE ?', "%#{author}%") if author.present?
    books = books.where('genre ILIKE ?', "%#{genre}%") if genre.present?

    @books = books
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies)
  end

  def authorize_librarian
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.librarian?
  end
end