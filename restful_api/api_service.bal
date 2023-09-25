import ballerina/http;

type Course record {
    string courseName;
    string courseCode;
    int NQFLevel;
};

type Lecturer record {
    string staffNumber;
    string officeNumber;
    string staffName;
    string title;
    Course[] courses;
};

map<Lecturer> lecturersMap = {};

service /dsa on new http:Listener(9090) {

    //add a  lecturer
    resource function post lecturers(http:Caller caller, http:Request req) returns error? {
        // Try to extract JSON payload from the request
        json|error jsonPayload = req.getJsonPayload();

        // Check if the provided payload is not a valid JSON
        if (jsonPayload is error) {
            check caller->respond({
                status: "error",
                message: "Invalid JSON provided",
                data: {}
            });
            return;
        }

        // Try to convert the JSON payload into a Lecturer type
        Lecturer|error lecturer = jsonPayload.cloneWithType(Lecturer);

        // Check if the provided JSON doesn't match the Lecturer schema
        if (lecturer is error) {
            check caller->respond({
                status: "error",
                message: "Provided JSON doesn't match the Lecturer schema",
                data: {}
            });
            return;
        }

        // Check if the lecturer with the given staffNumber already exists
        if (lecturersMap.hasKey(lecturer.staffNumber)) {
            check caller->respond({
                status: "error",
                message: "Lecturer with the given staffNumber already exists",
                data: {}
            });
            return;
        }

        // If no duplicates, add the lecturer to the in-memory map using their staff number as the key
        lecturersMap[lecturer.staffNumber] = lecturer;

        // Respond with a success message and HTTP CREATED status
        check caller->respond({
            status: "success",
            message: "Lecturer added successfully",
            data: lecturer
        });
    }

    //get all lectures 
    resource function get lecturers(http:Caller caller) returns error? {
        // Check if the in-memory map contains any lecturers
        if (lecturersMap.length() > 0) {
            // Fetch all lecturers from the in-memory map
            map<[string, Lecturer]> lecturers = lecturersMap.entries();

            // Respond with the list of all lecturers
            check caller->respond({
                status: "success",
                message: "Fetched all lecturers successfully.",
                data: lecturers
            });
        } else {
            // Respond with a message indicating that no lecturers were found
            check caller->respond({
                status: "error",
                message: "No lecturers found.",
                data: {}
            });
        }
    }

    //get lecturer by staffnumber
    resource function get lecturers/[string staffNumber](http:Caller caller) returns error? {
        // Check if the lecturer with the given staffNumber exists in the in-memory map
        if (lecturersMap.hasKey(staffNumber)) {

            // Retrieve the lecturer's details using the provided staffNumber
            Lecturer lecturer = <Lecturer>lecturersMap[staffNumber];

            // Respond with the lecturer's details
            check caller->respond({
                status: "success",
                message: "Lecturer details fetched successfully.",
                data: lecturer
            });
        } else {
            // If no lecturer is found with the given staffNumber, respond with an appropriate error message
            check caller->respond({
                status: "error",
                message: "No lecturer found with the given staff number.",
                data: null
            });
        }
    }

    //update lecturer by staff number
    resource function put lecturers/[string staffNumber](http:Caller caller, http:Request req) returns error? {
        // Extract the JSON payload from the request
        json|error jsonPayload = req.getJsonPayload();

        // Check if the payload extraction resulted in an error (e.g., invalid JSON format)
        if (jsonPayload is error) {
            check caller->respond({
                status: "error",
                message: "Invalid JSON provided."
            });
            return;
        }

        // Attempt to map the JSON payload to the Lecturer type
        Lecturer|error updatedLecturer = jsonPayload.cloneWithType(Lecturer);

        // Check if the mapping resulted in an error (e.g., the provided JSON doesn't match the Lecturer type)
        if (updatedLecturer is error) {
            check caller->respond({
                status: "error",
                message: "Provided JSON doesn't match the Lecturer schema."
            });
            return;
        }

        // Check if a lecturer with the provided staffNumber already exists
        if (lecturersMap.hasKey(staffNumber)) {
            // Update the lecturer details in the in-memory map
            lecturersMap[staffNumber] = updatedLecturer;

            // Respond with a success message
            check caller->respond({
                status: "success",
                message: "Lecturer updated successfully."
            });
        } else {
            // Respond with an error if the lecturer was not found
            check caller->respond({
                status: "error",
                message: "Lecturer not found."
            });
        }
    }

    //delete a lecturer by staff number
    resource function delete lecturers/[string staffNumber](http:Caller caller) returns error? {
        // Check if a lecturer with the given staffNumber exists in the map
        if (lecturersMap.hasKey(staffNumber)) {
            // Remove the lecturer from the in-memory map
            _ = lecturersMap.remove(staffNumber);

            // Respond with a success message after successful deletion
            check caller->respond({
                status: "success",
                message: "Lecturer with staff number " + staffNumber + " has been successfully deleted."
            });
        } else {
            // Respond with an error message if no lecturer is found with the given staffNumber
            check caller->respond({
                status: "error",
                message: "No lecturer found with staff number " + staffNumber + "."
            });
        }
    }

    //get all lecturers teaching the course with given course code
    resource function get lecturers/course/[string courseCode](http:Caller caller) returns error? {
        // Initialize an empty array to hold lecturers teaching the specified course
        Lecturer[] lecturers = [];

        // Iterate over all lecturers in the in-memory map
        foreach var [_, lecturer] in lecturersMap.entries() {
            // Check each course associated with the lecturer
            foreach var course in lecturer.courses {
                // If the course code matches the specified course, add the lecturer to the array
                if (course.courseCode == courseCode) {
                    lecturers.push(lecturer);
                    // Break out of the inner loop once the lecturer is added to avoid duplicate entries
                    break;
                }
            }
        }

        // Check if any lecturers were found for the specified course
        if (lecturers.length() > 0) {
            // Respond with a success message and the list of lecturers
            check caller->respond({
                status: "success",
                message: "Fetched lecturers for the course " + courseCode + " successfully.",
                data: lecturers
            });
        } else {
            // Respond with an error message indicating no lecturers were found for the specified course
            check caller->respond({
                status: "error",
                message: "No lecturers found for the course " + courseCode + ".",
                data: {}
            });
        }
    }

    //get lecturers at the given office number
    resource function get lecturers/office/[string officeNumber](http:Caller caller) returns error? {
        // Initialize an empty array to store lecturers belonging to the provided office number
        Lecturer[] lecturers = [];

        // Iterate through the in-memory map of lecturers
        foreach var [_, lecturer] in lecturersMap.entries() {
            // Check if the lecturer's office number matches the provided office number
            if (lecturer.officeNumber == officeNumber) {
                lecturers.push(lecturer); // If match found, add the lecturer to the result array
            }
        }

        // Check if we found any lecturers with the specified office number
        if (lecturers.length() > 0) {
            // Respond with a success message and the list of lecturers
            check caller->respond({
                status: "success",
                message: "Fetched lecturers for office number " + officeNumber + " successfully.",
                data: lecturers
            });
        } else {
            // Respond with an error message indicating that no lecturers were found for the given office number
            check caller->respond({
                status: "error",
                message: "No lecturers found for office number " + officeNumber + ".",
                data: {}
            });
        }
    }

}

public function main() returns error? {
    // this will start the HTTP server at port 9090
}
