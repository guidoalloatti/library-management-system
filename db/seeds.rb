# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  email: 'librarian@mail.com',
  password: '123456',
  role: 'librarian'
)

User.create(
  email: 'member@mail.com',
  password: '123456',
  role: 'member'
)

User.create(
  email: 'new_member@mail.com',
  password: '123456',
  role: 'member'
)

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

Book.create(
  title: "The Great Gatsby",
  author: "F. Scott Fitzgerald",
  genre: "Classic",
  isbn: "978-0-7432-7356-5",
  total_copies: 18
)

Book.create(
  title: "One Hundred Years of Solitude",
  author: "Gabriel García Márquez",
  genre: "Magical Realism",
  isbn: "978-0-06-112008-4",
  total_copies: 25
)

Book.create(
  title: "Lord of the Rings: The Fellowship of the Ring",
  author: "J.R.R. Tolkien",
  genre: "Fantasy",
  isbn: "978-0-395-19395-4",
  total_copies: 22
)

Book.create(
  title: "Harry Potter and the Sorcerer's Stone",
  author: "J.K. Rowling",
  genre: "Fantasy",
  isbn: "978-0-590-35340-3",
  total_copies: 30
)

Book.create(
  title: "Brave New World",
  author: "Aldous Huxley",
  genre: "Dystopian",
  isbn: "978-0-06-085052-4",
  total_copies: 17
)

Book.create(
  title: "The Hobbit",
  author: "J.R.R. Tolkien",
  genre: "Fantasy",
  isbn: "978-0-618-26030-0",
  total_copies: 18
)

Book.create(
  title: "Harry Potter and the Prisoner of Azkaban",
  author: "J.K. Rowling",
  genre: "Fantasy",
  isbn: "978-0-7475-4215-5",
  total_copies: 28
)
