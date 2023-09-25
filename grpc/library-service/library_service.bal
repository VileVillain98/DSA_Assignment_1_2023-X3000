import ballerina/grpc;

listener grpc:Listener ep = new (9090);

    // Use in-memory maps for storage.
    map<Book> books = {};
    map<User> users = {};  

@grpc:Descriptor {value: LIBRARY_DESC}


service "Library" on ep {



    remote function AddBook(AddBookRequest req) returns AddBookResponse|error {
        Book bookToAdd = req.book;
        books[bookToAdd.ISBN] = bookToAdd;
        return { ISBN: bookToAdd.ISBN };        
    }

    remote function UpdateBook(UpdateBookRequest req) returns UpdateBookResponse|error {
        Book bookToUpdate = req.book;
        if (books.hasKey(bookToUpdate.ISBN)) {
            books[bookToUpdate.ISBN] = bookToUpdate;
            return { status: "Book updated successfully" };
        }
        return { status: "Book not found" };        
    }

    remote function RemoveBook(RemoveBookRequest req) returns RemoveBookResponse|error {
        Book remove = books.remove(req.ISBN);

        Book[] remainingBooks = [];
        foreach var entry in books.entries() {
            remainingBooks.push(entry[1]); // Push the book (which is the value in the key-value pair)
        }

        return { books: remainingBooks };
    }


    remote function ListAvailableBooks(ListAvailableBooksRequest req) returns ListAvailableBooksResponse|error {
        Book[] availableBooks = [];
        foreach var entry in books.entries() {
            Book book = entry[1];
            if (book.status) {
                availableBooks.push(book);
            }
        }
        return { books: availableBooks };
    }


    remote function LocateBook(LocateBookRequest req) returns LocateBookResponse|error {
        if (books.hasKey(req.ISBN)) {
            Book book = <Book>books[req.ISBN];
            return { location: book.location, status: book.status };
        }
        return error("Book not found");        
    }

    remote function BorrowBook(BorrowBookRequest req) returns BorrowBookResponse|error {
        if (!users.hasKey(req.user_id)) {
            return { status: "User not found" };
        }

        if (books.hasKey(req.ISBN)) {
            Book book = <Book>books[req.ISBN];
            if (book.status) {
                book.status = false;
                books[req.ISBN] = book;
                return { status: "Book borrowed successfully" };
            }
            return { status: "Book is not available" };
        }
        return { status: "Book not found" };        
    }

    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        error? err = clientStream.forEach(function(User usr) {
            users[usr.user_id] = usr;
        });

        if (err is error) {
            return { status: "Failed to create users" };
        }

        return { status: "Users created successfully!" };

    }
}

