require 'rails_helper'

RSpec.describe "Borrowings API", type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:valid_borrowing_params) { { user_id: user.id, book_id: book.id } }

  before do
    sign_in user
  end

  describe "GET /api/borrowings" do
    it "returns a list of borrowings" do
      create_list(:borrowing, 3)

      get '/api/borrowings'

      expect(response).to have_http_status(200)
      expect(json_response.length).to eq(3)
    end
  end

  describe "POST /api/borrowings" do
    it "creates a new borrowing" do
      post '/api/borrowings', params: { borrowing: valid_borrowing_params }

      expect(response).to have_http_status(201)
      expect(Borrowing.count).to eq(1)
    end

    it "returns the created borrowing" do
      post '/api/borrowings', params: { borrowing: valid_borrowing_params }

      expect(response).to have_http_status(201)
      expect(json_response['user_id']).to eq(user.id)
      # Add more expectations based on your API response
    end

    it "requires valid parameters" do
      post '/api/borrowings', params: { borrowing: { user_id: user.id } }

      expect(response).to have_http_status(422) # Unprocessable Entity
      expect(json_response['errors']).to include("Book must exist")
    end
  end

  #TODO
    # Add similar tests for GET, PUT, and DELETE actions
end
