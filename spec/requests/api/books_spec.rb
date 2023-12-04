require 'rails_helper'

RSpec.describe "Books API", type: :request do
  describe "GET /api/books" do
    it "returns a list of books" do
      
      Book.create(
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        genre: "Classic",
        isbn: "978-0-06-112008-4",
        total_copies: 15
      )

      Book.create(
        title: "1984",
        author: "George Orwell",
        genre: "Dystopian",
        isbn: "978-0-452-28423-4",
        total_copies: 20
      )

      Book.create(
        title: "The Catcher in the Rye",
        author: "J.D. Salinger",
        genre: "Fiction",
        isbn: "978-0-316-76948-0",
        total_copies: 12
      )

      get '/api/books'

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe "GET /api/books/:id" do
    it "returns a single book by id" do
      book = Book.create(
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        genre: "Classic",
        isbn: "978-0-06-112008-4",
        total_copies: 15
      )

      get "/api/books/#{book.id}"

      p JSON.parse(response.body)["id"]


      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['id']).to eq(book.id)
    end
  end

  # TODO:
    # Add similar tests for POST, PUT, and DELETE actions
end
