// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnNumber {
    // Angka untuk data mahasiswa
    uint256 public studentId;
    uint256 public credits;

    constructor() {
        studentId = 2101001;
        credits = 0;
    }

    function changeStudentId(uint256 _newId) public {
        studentId = _newId;
    }

    function addCredits() public {
        credits = credits + 3;
        // Bisa juga ditulis: credits += 3;
    }
}