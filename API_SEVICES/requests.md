Based on the provided Ballerina service, here are the Postman requests to interact with the service:

1. **Create a Lecturer**
   * **Method**: POST
   * **URL**: `http://localhost:9090/dsa/lecturers`
   * **Body**:
     ```json
     {
       "staffNumber": "SN001",
       "officeNumber": "ON100",
       "staffName": "John Doe",
       "title": "Dr.",
       "courses": [
           {
               "courseName": "Data Structures",
               "courseCode": "DS101",
               "NQFLevel": 7
           }
       ]
     }
     ```

2. **Get All Lecturers**
   * **Method**: GET
   * **URL**: `http://localhost:9090/dsa/lecturers`

3. **Get a Lecturer by Staff Number**
   * **Method**: GET
   * **URL**: `http://localhost:9090/dsa/lecturers/SN001` (Replace `SN001` with the desired staff number)

4. **Update a Lecturer by Staff Number**
   * **Method**: PUT
   * **URL**: `http://localhost:9090/dsa/lecturers/SN001` (Replace `SN001` with the staff number to update)
   * **Body**:
     ```json
     {
       "staffNumber": "SN001",
       "officeNumber": "ON101",
       "staffName": "John Doe",
       "title": "Prof.",
       "courses": [
           {
               "courseName": "Advanced Data Structures",
               "courseCode": "ADS102",
               "NQFLevel": 8
           }
       ]
     }
     ```

5. **Delete a Lecturer by Staff Number**
   * **Method**: DELETE
   * **URL**: `http://localhost:9090/dsa/lecturers/SN001` (Replace `SN001` with the staff number to delete)

6. **Get Lecturers by Course Code**
   * **Method**: GET
   * **URL**: `http://localhost:9090/dsa/lecturers/course/DS101` (Replace `DS101` with the desired course code)

7. **Get Lecturers by Office Number**
   * **Method**: GET
   * **URL**: `http://localhost:9090/dsa/lecturers/office/ON100` (Replace `ON100` with the desired office number)

You can set up these requests in Postman, a popular tool for testing APIs. Ensure your Ballerina service is running on `localhost` port `9090` when sending these requests.