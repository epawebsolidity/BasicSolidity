// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnMapping {
    // Mapping: studentId => name
    mapping(uint256 => string) public studentName;

    // Mapping: studentId => credits
    mapping(uint256 => uint256) public studentCredits;

    function addStudent(uint256 _id, string memory _name) public {
        studentName[_id] = _name;
        studentCredits[_id] = 0;
    }

    function addCredits(uint256 _id, uint256 _amount) public {
        studentCredits[_id] += _amount;
    }
}