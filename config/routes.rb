Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  
  devise_for :users

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

  namespace :api do
    resources :books, only: [:index, :show, :create, :update, :destroy] do
      collection do
        get 'search'
      end
    end

    resources :borrowings, only: [:index, :show, :create, :update, :destroy]
    
    post 'borrowings/:id/return', to: 'borrowings#return', as: 'return_borrowing'
    get 'dashboard', to: 'dashboard#index', as: 'dashboard_index'
  end

  resources :borrowings
  resources :books

  resources :borrowings do
    member do
      patch 'return'
    end
  end

  post "remove_book" => "book#remove_book"
  get "books/:book_id/borrowings", to: "books#borrowings", as: 'book_borrowings'
  get "borrowings/:id/return", to: "borrowings#return", as: 'borrowing_return'

  # For Librarians
  get '/librarian/dashboard', to: 'librarians#dashboard'
  get '/librarian/logout', to: 'librarians#logout', as: :librarian_logout

  # For Members
  get '/member/dashboard', to: 'members#dashboard'
  get '/member/logout', to: 'members#logout', as: :member_logout
end
