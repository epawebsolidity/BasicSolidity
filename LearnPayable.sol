// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnPayable {
    uint256 public studentCounter;
    mapping(uint256 => address) public studentOwner;

    // Fungsi payable dapat menerima ETH
    function registerStudent() public payable returns (uint256) {
        require(msg.value >= 0.001 ether, "Perlu 0.001 ETH untuk registrasi");

        studentCounter++;
        studentOwner[studentCounter] = msg.sender;

        return studentCounter;
    }

    // Cek saldo contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}