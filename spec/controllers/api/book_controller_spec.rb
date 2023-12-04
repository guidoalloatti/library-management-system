require 'rails_helper'

RSpec.describe Api::BooksController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  let(:valid_book_params) { { title: "Test Book", author: "Test Author", genre: "Test Genre", isbn: "123456789", total_copies: 5 } }
  let(:user) { 
    User.create(
      email: 'librarian@mail.com',
      password: '123456',
      role: 'librarian'
    )
  }
  
  before do
    sign_in user
  end
  
  describe "POST /api/books" do
  it "creates a new book" do
      book_params = { title: "Test Book", author: "Test Author", genre: "Test Genre", isbn: "123456789", total_copies: 5 }
      
      post :create, params: { book: book_params }

      expect(response).to have_http_status(201)
      expect(Book.count).to eq(1)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      book = Book.create(
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        genre: "Classic",
        isbn: "978-0-06-112008-4",
        total_copies: 15
      )

      get :show, params: { id: book.id }

      expect(response).to have_http_status(200)
    end
  end

  # TODO:
    # Add similar tests for PUT and DELETE actions
end
