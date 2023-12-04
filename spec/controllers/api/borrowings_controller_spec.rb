require 'rails_helper'

RSpec.describe Api::BorrowingsController, type: :controller do
  
  let(:book) {
    Book.create(
      title: "The Catcher in the Rye",
      author: "J.D. Salinger",
      genre: "Fiction",
      isbn: "978-0-316-76948-0",
      total_copies: 12
    )
  }
  
  let(:user) { 
    User.create(
      email: 'librarian@mail.com',
      password: '123456',
      role: 'librarian'
    )
  }

  let(:borrowing) {
    Borrowing.create(
      user_id: user.id,
      book_id: book.id,
      borrowed_at: Time.now
    )
  }

  let(:valid_borrowing_params) { { user_id: user.id, book_id: book.id, borrowed_at: Time.now } }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "creates a new borrowing" do
      post :create, params: { borrowing: valid_borrowing_params }

      expect(response).to have_http_status(201)
      expect(Borrowing.count).to eq(1)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      # post :create, params: { borrowing: valid_borrowing_params }

      get :show, params: { id: borrowing.id }
      expect(response).to have_http_status(200)
    end
  end

  # Add similar tests for PUT and DELETE actions
end
