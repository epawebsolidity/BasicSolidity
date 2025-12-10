// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnArray {
    // Array untuk menyimpan student ID
    uint256[] public allStudentIds;

    // Tambah mahasiswa
    function addStudent(uint256 _id) public {
        allStudentIds.push(_id);
    }

    // Dapatkan total mahasiswa
    function getTotalStudents() public view returns (uint256) {
        return allStudentIds.length;
    }

    // Dapatkan semua student ID
    function getAllStudents() public view returns (uint256[] memory) {
        return allStudentIds;
    }

    // Dapatkan student tertentu by index
    function getStudentByIndex(uint256 _index) public view returns (uint256) {
        return allStudentIds[_index];
    }
}