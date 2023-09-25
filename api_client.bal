import ballerina/http;
import ballerina/io;

final string BASE_URL = "http://localhost:9090/dsa";

http:Client dsaHttpClient = check new (BASE_URL);

// Create a new lecturer in the system.
public function createLecturer(Lecturer lecturer) returns string|error {
    http:Response resp = check dsaHttpClient->post("/lecturers", lecturer);

    // If the status code indicates successful creation (HTTP 201 Created)
    if (resp.statusCode == 201) {
        return "Lecturer created successfully.";
    } else {
        // Return the error message received from the server
        return (check resp.getJsonPayload()).toString();
    }
}

// Fetch all the lecturers from the system.
public function getAllLecturers() returns error|json|http:ClientError {
    http:Response resp = check dsaHttpClient->get("/lecturers");
    // Return the list of lecturers as a JSON payload
    return resp.getJsonPayload();
}

// Fetch a specific lecturer by their staff number.
public function getLecturerByStaffNumber(string staffNumber) returns error|json|http:ClientError {
    http:Response resp = check dsaHttpClient->get("/lecturers/" + staffNumber);
    // Return the details of the requested lecturer as a JSON payload
    return resp.getJsonPayload();
}

// Update the details of a specific lecturer by their staff number.
public function updateLecturer(string staffNumber, Lecturer lecturer) returns string|error {
    http:Response resp = check dsaHttpClient->put("/lecturers/" + staffNumber, lecturer);
    // If successful, a success message is returned, otherwise an error message is returned
    return (check resp.getJsonPayload()).toString();
}

// Remove a lecturer from the system using their staff number.
public function deleteLecturer(string staffNumber) returns string|error {
    http:Response resp = check dsaHttpClient->delete("/lecturers/" + staffNumber);
    // If successful, a success message is returned, otherwise an error message is returned
    return (check resp.getJsonPayload()).toString();
}

// Fetch all lecturers teaching a particular course.
public function getLecturersByCourse(string courseCode) returns error|json|http:ClientError {
    http:Response resp = check dsaHttpClient->get("/lecturers/course/" + courseCode);
    // Return the list of lecturers teaching the specified course
    return resp.getJsonPayload();
}

// Fetch all lecturers located in a specific office.
public function getLecturersByOffice(string officeNumber) returns error|json|http:ClientError {
    http:Response resp = check dsaHttpClient->get("/lecturers/office/" + officeNumber);
    // Return the list of lecturers in the specified office
    return resp.getJsonPayload();
}


public type Course record {
    string courseName;
    string courseCode;
    int NQFLevel;
};

public type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    Course[] courses;
};

public function main() returns error? {
    Lecturer lecturer = {
        staffNumber: "SN001",
        officeNumber: "ON101",
        staffName: "John Smith",
        title: "Dr.",
        courses: [
            {
                courseName: "Data Structures",
                courseCode: "DSA101",
                NQFLevel: 4
            }
        ]
    };

    // Create lecturer
    string|error createResp = createLecturer(lecturer);
    if (createResp is string) {
        io:println(createResp);
    } else {
        io:println("Error creating lecturer:", createResp.message());
    }

    // Fetch all lecturers
    error|json allLecturers = getAllLecturers();

    if (allLecturers is map<[string, Lecturer]>) {
        io:println("All lecturers:", allLecturers);
    } else if (allLecturers is error) {
        io:println("Error fetching lecturers:", allLecturers.message());
    } else {
        io:println("Unexpected response:", allLecturers.toString());
    }

}
