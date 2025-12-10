// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MultipleStudents {
    enum StudentStatus { NotRegistered, Active, OnLeave, Graduated }

    struct Student {
        uint256 id;
        string name;
        address wallet;
        StudentStatus status;
        uint8 credits;
        bool exists;
    }

    // Mapping untuk menyimpan mahasiswa
    mapping(uint256 => Student) public students;

    // Counter
    uint256 public studentCounter;

    // Tambah mahasiswa baru
    function addStudent(string memory _name) public returns (uint256) {
        studentCounter++;

        students[studentCounter] = Student({
            id: studentCounter,
            name: _name,
            wallet: msg.sender,
            status: StudentStatus.Active,
            credits: 0,
            exists: true
        });

        return studentCounter;
    }

    // Tambah credits
    function addCredits(uint256 _id, uint8 _amount) public {
        students[_id].credits += _amount;
    }

    // Dapatkan info mahasiswa
    function getStudent(uint256 _id) public view returns (Student memory) {
        return students[_id];
    }

    // Check apakah mahasiswa exist
    function studentExists(uint256 _id) public view returns (bool) {
        return students[_id].exists;
    }
}