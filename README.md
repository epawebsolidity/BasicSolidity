# TESTING SMARTCONTRACT REMIX SOLIDITY MANTLE
# EduLoan - Mantle Co-Learning Camp Challenge

## Author
- Nama: Eko Purnama Azi 
- GitHub: epawebsolidity 
- Wallet: 0x980c047738c1402cdaa303315ec5aecb2a01b491

## Contract Address (Mantle Sepolia)
0x980c047738c1402cdaa303315ec5aecb2a01b491

## Features Implemented
- [✓] Apply Loan
- [✓] Approve/Reject Loan
- [✓] Disburse Loan
- [✓] Make Payment
- [x] Check Default
- [ ] Bonus: [sebutkan jika ada]

| Langkah         | Link Transaction                                                                                           |
| --------------- | ---------------------------------------------------------------------------------------------------------- |
| Deploy Contract | [Tx](https://sepolia.mantlescan.xyz/tx/0xdf079f9401bc2dd108b08fad1445dc9e27a2da09164ce116310324cbf35cc7ea) |
| Deposit Funds   | [Tx](https://sepolia.mantlescan.xyz/tx/0xb1cb7cdfa1da89fb089dc9562dcea7b346a54ad4e46a9312e05738673eb2ade5) |
| Apply Loan      | [Tx](https://sepolia.mantlescan.xyz/tx/0x7fb28590cad66b65806509cb463e511269679bf4df4cb9d522e6cec94ff68dc4) |
| Approve Loan    | [Tx](https://sepolia.mantlescan.xyz/tx/0x3c1704608844be574392e078e8e314915695ed33ea486b49e701a8196b18755b) |
| Disburse Loan   | [Tx](https://sepolia.mantlescan.xyz/tx/0x3248c135babf37157244741757ae3323d0db3448b47677f2a26e98443e580b9c) |
| Make Payment    | [Tx](https://sepolia.mantlescan.xyz/tx/0x00de816c582224031dbc5edd88cbb2db01d239f36ccee580d8aef452fb709cb2) |

| Step | Function / Action  | Loan ID | Borrower Address                           | Principal (wei)    | Interest (bps) | Total (wei)        | Amount Repaid (wei) | Application Time | Approval Time | Deadline   | Status    | Purpose                |
| ---- | ------------------ | ------- | ------------------------------------------ | ------------------ | -------------- | ------------------ | ------------------- | ---------------- | ------------- | ---------- | --------- | ---------------------- |
| 1    | `getLoanDetails()` | 0       | 0x0000000000000000000000000000000000000000 | 0                  | 0              | 0                  | 0                   | 0                | 0             | 0          | Pending   | -                      |
| 2    | `getLoanDetails()` | 1       | 0x980C047738C1402cDaA303315Ec5AEcb2A01b491 | 500000000000000000 | 500            | 525000000000000000 | 0                   | 1765507875       | 1765507993    | 0          | Approved  | Biaya Course HackQuest |
| 3    | `getLoanDetails()` | 1       | 0x980C047738C1402cDaA303315Ec5AEcb2A01b491 | 500000000000000000 | 500            | 525000000000000000 | 0                   | 1765507875       | 1765507993    | 1797044051 | Active    | Biaya Course HackQuest |
| 4   | `getLoanDetails()` | 1       | 0x980C047738C1402cDaA303315Ec5AEcb2A01b491 | 500000000000000000 | 500            | 525000000000000000 | 525000000000000000  | 1765507875       | 1765507993    | 1797044051 | Repaid    | Biaya Course HackQuest |
| 5   | `getLoanDetails()` | 1       | 0x980C047738C1402cDaA303315Ec5AEcb2A01b491 | 500000000000000000 | 500            | 525000000000000000 | 0                   | 1765507875       | 1765507993    | 1797044051 | Defaulted | Biaya Course HackQuest |


## Lessons Learned
[Tulis apa yang Anda pelajari dari challenge ini]

DONE
