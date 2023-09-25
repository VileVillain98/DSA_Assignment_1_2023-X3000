# You can use my template to make your API requests

## To add a book:

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/AddBook`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "book": {
        "title": "ballerina",
        "author_1": "ballerina",
        "author_2": "ballerina",
        "location": "ballerina",
        "ISBN": "ballerina",
        "status": true
    }
}
```

## To update a book: 

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/UpdateBook`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "book": {
        "title": "updated title",
        "author_1": "updated author",
        "author_2": "updated secondary author",
        "location": "updated location",
        "ISBN": "ballerina",
        "status": true
    }
}
```

## To remove a book:

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/RemoveBook`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "ISBN": "ballerina"
}
```

## To list all of the books:

**Endpoint:** 
- Method: `GET`
- URL: `grpc://localhost:9090/Library/ListAvailableBooks`

## To locate a book:

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/LocateBook`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "ISBN": "ballerina"
}
```

## To borrow a book:

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/BorrowBook`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "user_id": "ballerina_user",
    "ISBN": "ballerina"
}
```

## To create a user:

**Endpoint:** 
- Method: `POST`
- URL: `grpc://localhost:9090/Library/CreateUsers`

**Headers:** 
- Content-Type: `application/json`

**Body:**
```json
{
    "user_id": "ballerina_user",
    "profile": "STUDENT"
}

