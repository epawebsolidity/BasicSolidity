// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnStruct {
    enum StudentStatus { NotRegistered, Active, OnLeave, Graduated }

    struct Student {
        uint256 id;
        string name;
        address wallet;
        StudentStatus status;
        uint8 credits;
        bool isActive;
    }

    Student public myStudent;

    constructor() {
        myStudent = Student({
            id: 2101001,
            name: "Budi Santoso",
            wallet: msg.sender,
            status: StudentStatus.Active,
            credits: 0,
            isActive: true
        });
    }

    function addCredits() public {
        myStudent.credits += 3;
    }

    function changeStatus(StudentStatus _status) public {
        myStudent.status = _status;
    }
}