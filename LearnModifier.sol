// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnModifier {
    address public admin;
    mapping(uint256 => address) public studentOwner;
    mapping(uint256 => uint256) public studentCredits;
    uint256 public adminActionCount;

    constructor() {
        admin = msg.sender;
    }

    // Modifier: hanya admin yang bisa call
    modifier onlyAdmin() {
        require(msg.sender == admin, "Hanya admin!");
        _;
    }

    // Modifier: harus pemilik student
    modifier onlyStudentOwner(uint256 _id) {
        require(studentOwner[_id] == msg.sender, "Bukan student Anda!");
        _;
    }

    function registerStudent(uint256 _id) public {
        studentOwner[_id] = msg.sender;
        studentCredits[_id] = 0;
    }

    // Hanya admin yang bisa call ini
    function adminFunction() public onlyAdmin {
        adminActionCount++;
    }

    // Hanya pemilik student yang bisa add credits
    function addCredits(uint256 _id, uint256 _amount) public onlyStudentOwner(_id) {
        require(_amount > 0, "Amount harus lebih dari 0");
        studentCredits[_id] += _amount;
    }
}