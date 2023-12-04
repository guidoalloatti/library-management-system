# Library Management System

This is a Ruby on Rails web application for managing a library's book inventory and user borrowings.

## Table of Contents
- [Features](#features)
  - Authentication and Authorization
  - Book Management
  - Borrowing and Returning
  - Dashboard
- [API Endpoints](#api-endpoints)
- [Frontend](#frontend)
- [Tests](#tests)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Data Setup and Start Server](#server)

## Features
- **Authentication and Authorization:**
  - Users can register, log in, and log out.
  - Two types of users: Librarian and Member.
  - Only Librarian users can add, edit, or delete books.

- **Book Management:**
  - Add, edit, and delete books with details like title, author, genre, ISBN, and total copies.
  - Search functionality for books by title, author, or genre.

- **Borrowing and Returning:**
  - Members can borrow available books and cannot borrow the same book multiple times.
  - The system tracks borrowing and due dates.
  - Librarians can mark books as returned.

- **Dashboard:**
  - Librarian dashboard shows total books, total borrowed books, books due today, and members with overdue books.
  - Member dashboard shows borrowed books, due dates, and any overdue books.

## API Endpoints
  - RESTful API for CRUD operations on books and borrowings and session management for users.

  - **Users**
    - Before using the API you need to login making a reques as follows:
      - `POST http://localhost:3000/users/sign_in`
      -- You need to add the x-csrf-token to the headers and perform the the request with the following credentials (please remember to run the seeds before this step)
      
      - Librarian:
        ```json
        {
          "user": {
              "email": "librarian@mail.com",
              "password": "123456"
          }
        }
        ```

      - Member:
        ```json
        {
          "user": {
              "email": "member@mail.com",
              "password": "123456"
          }
        }
        ```
     - And you can logout using: 
      - `GET http://localhost:3000/member/logout`

  - **Books**
    - List Books: `GET localhost:3000/api/books`
    - Create Book: `POST localhost:3000/api/books`
      ```json
      {
        "book": {
          "title": "The Great Gatsby",
          "author": "F. Scott Fitzgerald", 
          "genre": "Classic",
          "isbn": "978-3-16-148410-0",
          "total_copies": 10
        }
      }
      ```
    - Show book details: GET localhost:3000/api/books/:id
    - Edit a Book: `PATCH localhost:3000/api/books/:id` 
      ```json
      {
        "book": {
          "title": "The Great Gatsby",
          "author": "F. Scott Fitzgerald", 
          "genre": "Classic",
          "isbn": "978-3-16-148410-0",
          "total_copies": 10
        }
      }
      ```
    - Remove a Book: DELETE localhost:3000/api/books/:id
    - Search Books: GET http://localhost:3000/api/books/search?title=rings&author=tolkien&genre=Fantasy

  - **Borrowings**
    - List all borrowings: `GET localhost:3000/api/borrowings`
    - Borrow a Book: `POST http://localhost:3000/api/borrowings`
      ```json
      {
        "borrowing": {
            "user_id": 2,
            "book_id": 2,
            "borrowed_at": "2023-01-01T12:00:00Z"
        }
      }
      ```
    - Show a particular borrow: `GET http://localhost:3000/api/borrowings/:borrowing_id`
    - Update a borrow: `PATCH http://localhost:3000/api/borrowings/:borrowing_id`
      ```json
      {
        "borrowing": {
            "due_date": "2023-12-27T22:36:02.882Z",
            "returned_at": "2023-12-26T23:11:14.793Z"
        }
      }
      ```
    - Delete a borrow: `DELETE http://localhost:3000/api/borrowings/:borrowing_id`
    - Return a Borrowed Book: `POST http://localhost:3000/api/borrowings/:borrowing_id/return`

## Frontend
   - Simplified and user-friendly frontend created directly in the rails app.

   - In order to use it you can sign in as one of the two roles: member or librarian. Each different role will have a customized dashboard and will be able to perform different actions.

  - **Members Dashboard**
    ![Member Dashboard](https://github.com/guidoalloatti/library-management-system/blob/main/app/assets/images/member_dashboard.png)
   
    - In this page, members can:
      - See a list of available books and to borrow one. One member can have only one copy at a time for a paticular title
      - See a list of all the current borrowed books and will be able to return the titles.
      - See a list of recently returned books with information of the borrows and the book: title, author, genre and returned date.
      - See a list of the overdue books which due dates are passed.
      - Can logout at any time by clicking the Logout button on the top right corner.

  - **Librarians Dashboard**
    ![Librarian Dashboard](https://github.com/guidoalloatti/library-management-system/blob/main/app/assets/images/librarian_dashboard.png)

    - In this page, librarians can:
      - See an overview section on their dasboard which includes information of the total books, total borrowed books and books due today.
      - See a section with the members with Overdue Books.
      - See a section with the recently returned books.
      - Can manage the book by clicking on the Manage Books at the top right corner.
      - Logout at any time with the button on the top right corner.

  - **Librarian Books Management**
    ![book management](https://github.com/guidoalloatti/library-management-system/blob/main/app/assets/images/librarian_books_management.png)

    - In this page, librarians can:
      - From the dashboard, the librarian can access the Book Inventory page by clicking on the Manage Books button.
      - See a list of all the books, with detailed information for the title, author, genre, isbn, all time borrowed, currently borrowed and available.
      - Perform different actions for each book: manage the book borrowings, show the book details, edit the book information or remove the title.
      - Create a new book by clicking on the New Book button at the top right corner.
      - Can return to the dashboard at any time by clicking the Librarian Dashboard button on the top right corner.
      - Can logout at any time by clicking the Logout button on the top right corner.
        
  - **Librarian Book Borrowings**
    ![book borrowings](https://github.com/guidoalloatti/library-management-system/blob/main/app/assets/images/librarian_borrowings.png)
   
    - In this page, librarians can:
      - From the books management, a librarian can access the Book Borrowings page by clicking the Borrowings button in the actions section for a book.
      - See a list of all the borrowings for the selected book.
      - Can return the book of a particular borrowing by clicking on the Return Book button.
      - Can manage the book by clicking on the Back to Manage Books at the top right corner.
      - Can return to the dashboard at any time by clicking the Librarian Dashboard button on the top right corner.
      - Can logout at any time by clicking the Logout button on the top right corner.
     
  - **Notifications System**
    - There are alerts and success messages on top for the most important events at system level.

## Tests 
  ### Added several unit tests to following entities:
    - Books
       - Model
       - Api
       - Controller
     - Borrowings
       - Model
       - Api
       - Controlle
     - Users
 
## Getting Started

### Prerequisites
  - Ruby
  - Rails
  - PostgreSQL

### Installation

1. Clone the repository and bundle:

  ```bash
  git clone https://github.com/guidoalloatti/library-management-system.git
  cd library-management-system
  bundle install
  ```

2. Setup Rails database:
  ```bash
  rails db:create
  rails db:migrate
  rails db:seed
  ```

3. Start the rails server
  ```bash
  rails server
  ```
