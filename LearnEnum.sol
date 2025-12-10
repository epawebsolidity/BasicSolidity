// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract LearnEnum {
    enum StudentStatus {
        NotRegistered,  // 0
        Active,         // 1
        OnLeave,        // 2
        Graduated,      // 3
        Dropped         // 4
    }

    StudentStatus public currentStatus;

    constructor() {
        currentStatus = StudentStatus.NotRegistered;
    }

    function register() public {
        currentStatus = StudentStatus.Active;
    }

    function takeLeave() public {
        if (currentStatus == StudentStatus.Active) {
            currentStatus = StudentStatus.OnLeave;
        }
    }

    function graduate() public {
        if (currentStatus == StudentStatus.Active) {
            currentStatus = StudentStatus.Graduated;
        }
    }
}