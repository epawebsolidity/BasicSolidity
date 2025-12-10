// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnSendETH {
    address public admin;
    mapping(address => uint256) public scholarships;

    constructor() {
        admin = msg.sender;
    }

    // Terima ETH untuk scholarship fund
    function deposit() public payable {}

    // Kirim scholarship ke student
    function sendScholarship(address _student, uint256 _amount) public {
        require(msg.sender == admin, "Hanya admin");
        require(address(this).balance >= _amount, "Saldo tidak cukup");

        // Kirim ETH
        (bool success, ) = _student.call{value: _amount}("");
        require(success, "Transfer gagal");

        scholarships[_student] += _amount;
    }

    // Cek saldo
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}