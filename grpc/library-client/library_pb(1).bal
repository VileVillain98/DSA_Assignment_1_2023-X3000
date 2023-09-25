import ballerina/grpc;
import ballerina/protobuf;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F229A010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E12160A06737461747573180620012808520673746174757322470A045573657212170A07757365725F6964180120012809520675736572496412260A0770726F66696C6518022001280E320C2E5573657250726F66696C65520770726F66696C65222B0A0E416464426F6F6B5265717565737412190A04626F6F6B18012001280B32052E426F6F6B5204626F6F6B22250A0F416464426F6F6B526573706F6E736512120A044953424E18012001280952044953424E222D0A134372656174655573657273526573706F6E736512160A067374617475731801200128095206737461747573222E0A11557064617465426F6F6B5265717565737412190A04626F6F6B18012001280B32052E426F6F6B5204626F6F6B222C0A12557064617465426F6F6B526573706F6E736512160A06737461747573180120012809520673746174757322270A1152656D6F7665426F6F6B5265717565737412120A044953424E18012001280952044953424E22310A1252656D6F7665426F6F6B526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B73221B0A194C697374417661696C61626C65426F6F6B735265717565737422390A1A4C697374417661696C61626C65426F6F6B73526573706F6E7365121B0A05626F6F6B7318012003280B32052E426F6F6B5205626F6F6B7322270A114C6F63617465426F6F6B5265717565737412120A044953424E18012001280952044953424E22480A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E12160A06737461747573180220012808520673746174757322400A11426F72726F77426F6F6B5265717565737412170A07757365725F6964180120012809520675736572496412120A044953424E18022001280952044953424E222C0A12426F72726F77426F6F6B526573706F6E736512160A0673746174757318012001280952067374617475732A290A0B5573657250726F66696C65120B0A0753545544454E541000120D0A094C494252415249414E10013290030A074C696272617279122C0A07416464426F6F6B120F2E416464426F6F6B526571756573741A102E416464426F6F6B526573706F6E7365122C0A0B437265617465557365727312052E557365721A142E4372656174655573657273526573706F6E7365280112350A0A557064617465426F6F6B12122E557064617465426F6F6B526571756573741A132E557064617465426F6F6B526573706F6E736512350A0A52656D6F7665426F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E7365124D0A124C697374417661696C61626C65426F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A1B2E4C697374417661696C61626C65426F6F6B73526573706F6E736512350A0A4C6F63617465426F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512350A0A426F72726F77426F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E7365620670726F746F33";

public isolated client class LibraryClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function AddBook(AddBookRequest|ContextAddBookRequest req) returns AddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddBookResponse>result;
    }

    isolated remote function AddBookContext(AddBookRequest|ContextAddBookRequest req) returns ContextAddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddBookRequest message;
        if req is ContextAddBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddBookResponse>result, headers: respHeaders};
    }

    isolated remote function UpdateBook(UpdateBookRequest|ContextUpdateBookRequest req) returns UpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateBookResponse>result;
    }

    isolated remote function UpdateBookContext(UpdateBookRequest|ContextUpdateBookRequest req) returns ContextUpdateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateBookRequest message;
        if req is ContextUpdateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateBookResponse>result, headers: respHeaders};
    }

    isolated remote function RemoveBook(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function RemoveBookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function ListAvailableBooks(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableBooksResponse>result;
    }

    isolated remote function ListAvailableBooksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextListAvailableBooksResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableBooksResponse>result, headers: respHeaders};
    }

    isolated remote function LocateBook(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function LocateBookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function BorrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function BorrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Library/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Library/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookRequest record {|
    AddBookRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookResponse record {|
    AddBookResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksResponse record {|
    ListAvailableBooksResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookRequest record {|
    UpdateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateBookResponse record {|
    UpdateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    string user_id = "";
    UserProfile profile = STUDENT;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookRequest record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookResponse record {|
    string status = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksRequest record {|
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookRequest record {|
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookResponse record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookRequest record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookResponse record {|
    string location = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooksResponse record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string ISBN = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookRequest record {|
    Book book = {};
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookRequest record {|
    string user_id = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UpdateBookResponse record {|
    string status = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type CreateUsersResponse record {|
    string status = "";
|};

public enum UserProfile {
    STUDENT, LIBRARIAN
}

