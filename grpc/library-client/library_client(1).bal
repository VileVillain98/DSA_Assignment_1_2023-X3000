import ballerina/io;

LibraryClient ep = check new ("http://localhost:9090");

public function main() returns error? {

    // Add a book
    AddBookRequest addReq = {book: {title: "Sample Book", author_1: "Author", ISBN: "123456789", location: "Shelf A", status: true}};
    var addResponse = ep->AddBook(addReq);
    if (addResponse is AddBookResponse) {
        io:println("Added Book with ISBN: ", addResponse.ISBN);
    } else {
        io:println("Error in adding book: ", addResponse.message());
    }


    //update book details
    UpdateBookRequest updateReq = {book: {title: "Updated Book", author_1: "Updated Author", ISBN: "123456789", location: "Shelf B", status: true}};
    var updateResponse = ep->UpdateBook(updateReq);
    if (updateResponse is UpdateBookResponse) {
        io:println(updateResponse.status);
    } else {
        io:println("Error in updating book: ", updateResponse.message());
    }

    // Remove a book
    RemoveBookRequest removeReq = {ISBN: "123456789"};
    var removeResponse = ep->RemoveBook(removeReq);
    if (removeResponse is RemoveBookResponse) {
        io:println("Book removed. Updated list of books:");
        foreach Book book in removeResponse.books {
            io:println("Title: ", book.title, " ISBN: ", book.ISBN);
        }
    } else {
        io:println("Error in removing book: ", removeResponse.message());
    }

    // List available books
    var listResponse = ep->ListAvailableBooks({});
    if (listResponse is ListAvailableBooksResponse) {
        io:println("Available Books:");
        foreach Book book in listResponse.books {
            io:println("Title: ", book.title, " ISBN: ", book.ISBN);
        }
    } else {
        io:println("Error in listing books: ", listResponse.message());
    }

    // Locate a book using its ISBN
    LocateBookRequest locateReq = {ISBN: "123456789"};
    var locateResponse = ep->LocateBook(locateReq);
    if (locateResponse is LocateBookResponse) {
        if (locateResponse.status) {
            io:println("Book Location: ", locateResponse.location);
        } else {
            io:println("Book not available");
        }
    } else {
        io:println("Error in locating book: ", locateResponse.message());
    }

    // Borrow a book
    BorrowBookRequest borrowReq = {user_id: "U001", ISBN: "123456789"};
    var borrowResponse = ep->BorrowBook(borrowReq);
    if (borrowResponse is BorrowBookResponse) {
        io:println(borrowResponse.status);
    } else {
        io:println("Error in borrowing book: ", borrowResponse.message());
    }

    // Create users
    User user1 = {user_id: "U001", profile: STUDENT};
    User user2 = {user_id: "U002", profile: LIBRARIAN};

    // Create the streaming client
    CreateUsersStreamingClient createUserClient = check ep->CreateUsers();

    // Send users one by one
    check createUserClient->sendUser(user1);
    check createUserClient->sendUser(user2);

    // Complete the client-side streaming
    check createUserClient->complete();

    // Receive the response and handle it
    var responseResult = createUserClient->receiveCreateUsersResponse();
    if (responseResult is CreateUsersResponse) {
        io:println(responseResult.status);
    } else if (responseResult is error) {
        io:println("Error in creating users: ", responseResult.message());
    }
}

