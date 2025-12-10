// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnEvents {
    // Deklarasi event
    event StudentRegistered(address indexed owner, uint256 indexed studentId, string name);
    event CreditsAdded(uint256 indexed studentId, uint256 credits, uint256 totalCredits);

    mapping(uint256 => address) public studentOwner;
    mapping(uint256 => string) public studentName;
    mapping(uint256 => uint256) public studentCredits;
    uint256 public studentCounter;

    function registerStudent(string memory _name) public {
        studentCounter++;
        studentOwner[studentCounter] = msg.sender;
        studentName[studentCounter] = _name;
        studentCredits[studentCounter] = 0;

        // Emit event
        emit StudentRegistered(msg.sender, studentCounter, _name);
    }

    function addCredits(uint256 _id, uint256 _amount) public {
        require(studentOwner[_id] == msg.sender, "Bukan student Anda!");
        require(_amount > 0, "Amount harus lebih dari 0");

        studentCredits[_id] += _amount;

        // Emit event
        emit CreditsAdded(_id, _amount, studentCredits[_id]);
    }
}