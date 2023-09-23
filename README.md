# DSA_Assignment_1_2023-X3000
Distributed Systems and Applications Assignment 1 on Restful APIs and Remote Invocation with Ballerina 

# Q1: Restful API.

The goal is to create a Restful API to manage staff, offices, and courses within the Faculty of Computing and Informatics. Offices can have multiple lecturers, and each lecturer has attributes like staff number, office number, staff name, title, and a list of courses they teach. Courses have attributes like course name, course code, and NQF level. The API should provide these functions:
- Add a new lecturer
- List all lecturers in the faculty
- Update lecturer information
- Get details of a lecturer by staff number
- Delete a lecturer by staff number
- List lecturers teaching a specific course
- List lecturers sharing the same office.

Staff numbers are unique identifiers for lecturers. The API should adhere to the OpenAPI standard and be implemented in the Ballerina language.

# Q2: Library System Using gRPC

The goal is to create a library system using gRPC for two types of users: students and librarians. Students can view available books, borrow, search, locate, and return books. Librarians can add, update, remove books, and list borrowed ones. Key operations include:

- add_book: Librarian adds a book with title, authors, location, ISBN, and availability, returning the ISBN.
- create_users: Multiple users with different profiles are created and streamed to the server.
- update-book: Librarian modifies book details.
- remove-book: Librarian deletes a book, returning the updated book list.
- List_available_books: Students get a list of available books.
- locate_book: Students search for a book by ISBN and get its location if available.
- borrow-book: Students borrow a book with their user ID and the book's ISBN.

The task involves defining a protocol buffer contract and implementing client and server in Ballerina. Clients should use the generated gRPC client code for operations, handle user input, and display relevant information.

