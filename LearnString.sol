// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnString {
    // Variabel string untuk menyimpan nama mahasiswa
    string public studentName;

    // Constructor mengatur nilai awal
    constructor() {
        studentName = "Budi Santoso";
    }

    // Fungsi untuk mengubah nama
    function changeName(string memory _newName) public {
        studentName = _newName;
    }
}