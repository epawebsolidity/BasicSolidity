// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnTime {
    mapping(uint256 => uint256) public studentRegisteredTime;
    mapping(uint256 => uint256) public lastSubmission;

    uint256 public constant ASSIGNMENT_COOLDOWN = 1 days;

    function registerStudent(uint256 _id) public {
        studentRegisteredTime[_id] = block.timestamp;
    }

    // Check berapa lama sudah terdaftar (dalam detik)
    function getStudentAge(uint256 _id) public view returns (uint256) {
        require(studentRegisteredTime[_id] > 0, "Student belum terdaftar");
        return block.timestamp - studentRegisteredTime[_id];
    }

    // Submit assignment (max 1x per hari)
    function submitAssignment(uint256 _id) public {
        require(
            block.timestamp >= lastSubmission[_id] + ASSIGNMENT_COOLDOWN,
            "Harus tunggu 1 hari"
        );

        lastSubmission[_id] = block.timestamp;
    }

    // Check kapan bisa submit lagi
    function timeUntilNextSubmission(uint256 _id) public view returns (uint256) {
        if (lastSubmission[_id] == 0) {
            return 0; // Bisa submit sekarang
        }

        uint256 nextSubmissionTime = lastSubmission[_id] + ASSIGNMENT_COOLDOWN;

        if (block.timestamp >= nextSubmissionTime) {
            return 0; // Bisa submit sekarang
        }

        return nextSubmissionTime - block.timestamp;
    }
}