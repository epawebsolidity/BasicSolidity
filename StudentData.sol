// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract StudentData {

    string public studentName;
    uint256 public studentId;
    bool public isActive;
    address public studentAdress;
    uint256 public registerTime; 


    constructor() {
        studentName = "Eko Purnama Azi";
        studentId = 123456789;
        isActive = true;
        studentAdress = msg.sender;
        registerTime = block.timestamp;
    }

}