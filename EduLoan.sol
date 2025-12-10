// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title EduLoan - Decentralized Student Loan System
/// @author [Nama Anda]
/// @notice Sistem pinjaman pendidikan terdesentralisasi di Mantle Network
/// @dev Challenge Final Mantle Co-Learning Camp

contract EduLoan {
    // ============================================
    // ENUMS & STRUCTS
    // ============================================

    enum LoanStatus {
        Pending,
        Approved,
        Active,
        Repaid,
        Defaulted
    }

    struct Loan {
        uint256 loanId;
        address borrower;
        uint256 principalAmount;
        uint256 interestRate;
        uint256 totalAmount;
        uint256 amountRepaid;
        uint256 applicationTime;
        uint256 approvalTime;
        uint256 deadline;
        LoanStatus status;
        string purpose;
    }

    // ============================================
    // STATE VARIABLES
    // ============================================

    address public admin;
    uint256 public loanCounter;
    uint256 public constant INTEREST_RATE = 500; // 5% dalam basis points
    uint256 public constant LOAN_DURATION = 365 days;
    uint256 public constant MIN_LOAN = 0.01 ether;
    uint256 public constant MAX_LOAN = 10 ether;

    mapping(uint256 => Loan) public loans;
    mapping(address => uint256[]) public borrowerLoans;


    // ============================================
    // EVENTS
    // ============================================


    event LoanApplied(uint256 indexed loanId, address indexed borrower, uint256 amount, string purpose);
    event LoanApproved(uint256 indexed loanId, address indexed borrower, uint256 totalAmount);
    event LoanRejected(uint256 indexed loanId, address indexed borrower, string reason);
    event LoanDisbursed(uint256 indexed loanId, address indexed borrower, uint256 amount);
    event PaymentMade(uint256 indexed loanId, address indexed borrower, uint256 amount, uint256 remaining);
    event LoanRepaid(uint256 indexed loanId, address indexed borrower);
    event LoanDefaulted(uint256 indexed loanId, address indexed borrower);

    // ============================================
    // MODIFIERS
    // ============================================


     modifier onlyAdmin() {
        require(msg.sender == admin, "Hanya admin yang bisa melakukan ini");
        _;
    }

    modifier onlyBorrower(uint256 _loanId) {
        require(loans[_loanId].borrower == msg.sender, "Hanya peminjam yang bisa melakukan ini");
        _;
    }

    modifier loanExists(uint256 _loanId) {
        require(loans[_loanId].loanId != 0, "Pinjaman tidak ditemukan");
        _;
    }

    modifier inStatus(uint256 _loanId, LoanStatus _status) {
        require(loans[_loanId].status == _status, "Status pinjaman tidak sesuai");
        _;
    }

    // TODO: Buat modifiers (onlyAdmin, onlyBorrower, dll)


    // ============================================
    // CONSTRUCTOR
    // ============================================

    constructor() {
         admin = msg.sender; // TODO: Set admin = msg.sender
    }

    // ============================================
    // MAIN FUNCTIONS
    // ============================================

    /// @notice Mahasiswa mengajukan pinjaman
    /// @param _amount Jumlah pinjaman yang diajukan
    /// @param _purpose Tujuan pinjaman
    function applyLoan(uint256 _amount, string memory _purpose) public {
         require(_amount >= MIN_LOAN && _amount <= MAX_LOAN, "Jumlah pinjaman tidak valid");

        loanCounter++;
        uint256 totalAmount = _amount + calculateInterest(_amount);

        loans[loanCounter] = Loan({
            loanId: loanCounter,
            borrower: msg.sender,
            principalAmount: _amount,
            interestRate: INTEREST_RATE,
            totalAmount: totalAmount,
            amountRepaid: 0,
            applicationTime: block.timestamp,
            approvalTime: 0,
            deadline: 0,
            status: LoanStatus.Pending,
            purpose: _purpose
        });

        borrowerLoans[msg.sender].push(loanCounter);
        emit LoanApplied(loanCounter, msg.sender, _amount, _purpose);
    }

    /// @notice Admin menyetujui pinjaman
    /// @param _loanId ID pinjaman yang disetujui
    function approveLoan(uint256 _loanId) public {
        loans[_loanId].status = LoanStatus.Approved;
        loans[_loanId].approvalTime = block.timestamp;
        emit LoanApproved(_loanId, loans[_loanId].borrower, loans[_loanId].totalAmount);
    }

    /// @notice Admin menolak pinjaman
    /// @param _loanId ID pinjaman yang ditolak
    /// @param _reason Alasan penolakan
    function rejectLoan(uint256 _loanId, string memory _reason) public {
        loans[_loanId].status = LoanStatus.Defaulted;
        emit LoanRejected(_loanId, loans[_loanId].borrower, _reason);
    }

    /// @notice Admin mencairkan dana pinjaman
    /// @param _loanId ID pinjaman yang dicairkan
    function disburseLoan(uint256 _loanId) public {
        require(address(this).balance >= loans[_loanId].principalAmount, "Saldo kontrak tidak cukup");

        loans[_loanId].status = LoanStatus.Active;
        loans[_loanId].deadline = block.timestamp + LOAN_DURATION;
        payable(loans[_loanId].borrower).transfer(loans[_loanId].principalAmount);

        emit LoanDisbursed(_loanId, loans[_loanId].borrower, loans[_loanId].principalAmount);
    }

    /// @notice Borrower membayar cicilan
    /// @param _loanId ID pinjaman
    function makePayment(uint256 _loanId) public payable {
         require(msg.value > 0, "Jumlah pembayaran tidak valid");

        loans[_loanId].amountRepaid += msg.value;
        uint256 remainingAmount = getRemainingAmount(_loanId);

        if (remainingAmount == 0) {
            loans[_loanId].status = LoanStatus.Repaid;
            emit LoanRepaid(_loanId, msg.sender);
        }

        emit PaymentMade(_loanId, msg.sender, msg.value, remainingAmount);
    }

    /// @notice Cek apakah pinjaman sudah default
    /// @param _loanId ID pinjaman
    function checkDefault(uint256 _loanId) public {
        require(loans[_loanId].status == LoanStatus.Active, "Pinjaman tidak aktif");

        if (block.timestamp > loans[_loanId].deadline && loans[_loanId].amountRepaid < loans[_loanId].totalAmount) {
            loans[_loanId].status = LoanStatus.Defaulted;
            emit LoanDefaulted(_loanId, loans[_loanId].borrower);
        }
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /// @notice Lihat detail pinjaman
    function getLoanDetails(uint256 _loanId) public view returns (Loan memory) {
        return loans[_loanId];
    }

    /// @notice Lihat semua pinjaman milik caller
    function getMyLoans() public view returns (uint256[] memory) {
        return borrowerLoans[msg.sender];
    }

    /// @notice Hitung bunga dari principal
    function calculateInterest(uint256 _principal) public pure returns (uint256) {
        return (_principal * INTEREST_RATE) / 10000;
    }

    /// @notice Lihat sisa yang harus dibayar
    function getRemainingAmount(uint256 _loanId) public view returns (uint256) {
        uint256 totalRepaid = loans[_loanId].amountRepaid;
        return loans[_loanId].totalAmount - totalRepaid;
    }

    /// @notice Lihat saldo contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // ============================================
    // ADMIN FUNCTIONS
    // ============================================

    /// @notice Admin deposit dana ke contract
    function depositFunds() public payable onlyAdmin {
        // TODO: Implementasi (onlyAdmin)
    }

    /// @notice Admin withdraw dana dari contract
    function withdrawFunds(uint256 _amount) public {
        require(address(this).balance >= _amount, "Saldo kontrak tidak cukup");
        payable(admin).transfer(_amount);
    }
}