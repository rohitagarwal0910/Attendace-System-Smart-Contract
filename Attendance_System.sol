pragma solidity ^0.6.11;

contract AttendanceSystem {
    
    address public owner;
    
    struct Student {
        string name;
        uint attendance;
        bool registered;
    }
    
    mapping(address => Student) private students;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function addStudent(string memory studentName) public returns (bool){
        require(bytes(students[msg.sender].name).length == 0, "Already added");
        require(bytes(studentName).length != 0, "Name Required");
        students[msg.sender] = Student(studentName, 0, false);
        return true;
    }
    
    function validateRegistration(address studentAddress) public returns (bool) {
        require(msg.sender == owner, "Not Authorized");
        require(bytes(students[studentAddress].name).length != 0, "Not enrolled in class");
        students[studentAddress].registered = true;
        return true;
    }
    
    function createAttendance(address studentAddress) public returns (uint) {
        require(msg.sender == owner, "Not Authorized");
        require(bytes(students[studentAddress].name).length != 0, "Not enrolled in class");
        require(students[studentAddress].registered, "Registration not validated");
        students[studentAddress].attendance++;
        return students[studentAddress].attendance;
    }
    
    function getAttendance() view public returns (uint) {
        require(bytes(students[msg.sender].name).length != 0, "Not enrolled in class");
        require(students[msg.sender].registered, "Registration not validated");
        return students[msg.sender].attendance;
    }
    
}