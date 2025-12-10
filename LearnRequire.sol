// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnRequire {
    mapping(uint256 => address) public studentOwner;
    mapping(uint256 => uint256) public studentCredits;

    function registerStudent(uint256 _id) public {
        studentOwner[_id] = msg.sender;
        studentCredits[_id] = 0;
    }

    function addCredits(uint256 _id, uint256 _amount) public {
        // Cek apakah caller adalah pemilik student
        require(studentOwner[_id] == msg.sender, "Bukan student Anda!");

        // Cek amount valid
        require(_amount > 0, "Amount harus lebih dari 0");

        studentCredits[_id] += _amount;
    }
}