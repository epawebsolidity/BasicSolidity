// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnAddress {
    address public admin;
    address public student;

    constructor() {
        admin = msg.sender;  // msg.sender = alamat wallet Anda
    }

    function setStudent(address _student) public {
        student = _student;
    }
}