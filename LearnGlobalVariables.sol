// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnGlobalVariables {
    // ============================================
    // BLOCK PROPERTIES
    // ============================================

    // Mendapatkan waktu block saat ini
    function getCurrentTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    // Mendapatkan nomor block saat ini
    function getCurrentBlockNumber() public view returns (uint256) {
        return block.number;
    }

    // Mendapatkan chain ID (Mantle Sepolia = 5003)
    function getChainId() public view returns (uint256) {
        return block.chainid;
    }

    // Mendapatkan alamat validator/miner
    function getBlockCoinbase() public view returns (address) {
        return block.coinbase;
    }

    // Mendapatkan gas limit block
    function getBlockGasLimit() public view returns (uint256) {
        return block.gaslimit;
    }

    // Mendapatkan hash dari block sebelumnya
    function getPreviousBlockHash() public view returns (bytes32) {
        return blockhash(block.number - 1);
    }

    // ============================================
    // MESSAGE (MSG) PROPERTIES
    // ============================================

    // Mendapatkan alamat pemanggil fungsi
    function getMsgSender() public view returns (address) {
        return msg.sender;
    }

    // Mendapatkan jumlah MNT/ETH yang dikirim (dalam wei)
    function getMsgValue() public payable returns (uint256) {
        return msg.value;
    }

    // Mendapatkan calldata lengkap
    function getMsgData() public pure returns (bytes calldata) {
        return msg.data;
    }

    // Mendapatkan function selector (4 bytes pertama)
    function getMsgSig() public pure returns (bytes4) {
        return msg.sig;
    }

    // ============================================
    // TRANSACTION (TX) PROPERTIES
    // ============================================

    // Mendapatkan alamat EOA yang memulai transaksi
    function getTxOrigin() public view returns (address) {
        return tx.origin;
    }

    // Mendapatkan harga gas transaksi
    function getTxGasPrice() public view returns (uint256) {
        return tx.gasprice;
    }

    // ============================================
    // CONTRACT PROPERTIES
    // ============================================

    // Mendapatkan alamat contract ini
    function getContractAddress() public view returns (address) {
        return address(this);
    }

    // Mendapatkan saldo contract (dalam wei)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // ============================================
    // PRACTICAL EXAMPLES
    // ============================================

    address public owner;
    uint256 public deployTime;
    uint256 public deployBlock;

    constructor() {
        owner = msg.sender;           // Simpan alamat deployer
        deployTime = block.timestamp; // Simpan waktu deploy
        deployBlock = block.number;   // Simpan block deploy
    }

    // Contoh: Hanya owner yang bisa memanggil
    function onlyOwnerCanCall() public view returns (string memory) {
        require(msg.sender == owner, "Bukan owner!");
        return "Anda adalah owner!";
    }

    // Contoh: Hitung berapa lama contract sudah di-deploy
    function getContractAge() public view returns (uint256) {
        return block.timestamp - deployTime;
    }

    // Contoh: Hitung berapa block sejak deploy
    function getBlocksSinceDeploy() public view returns (uint256) {
        return block.number - deployBlock;
    }

    // Contoh: Terima MNT/ETH dan catat pengirim
    event Received(address indexed sender, uint256 amount, uint256 timestamp);

    function deposit() public payable {
        emit Received(msg.sender, msg.value, block.timestamp);
    }

    // Contoh: Validasi chain ID (pastikan di Mantle Sepolia)
    function validateChain() public view returns (bool) {
        return block.chainid == 5003; // Mantle Sepolia Chain ID
    }
}