// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract DSBank {
    struct User {
        uint totalLend;
        uint totalBorrow;
        DepositPayment[] depositPayments;
        BorrowPayment[] borrowPayments;
    }

    struct DepositPayment {
        uint amount;
        uint depositTime;
    }

    struct BorrowPayment {
        uint collateral;
        uint amount;
        uint borrowTime;
    }

    uint private liquidityPool;
    mapping(address => User) listUsers;

    function deposit() external payable {
        // VALIDATE
        require((msg.value > 0), 'Deposit must be greater than 0.');

        // DEPOSIT
        User storage user = listUsers[msg.sender];

        // Add user payment
        DepositPayment memory payment = DepositPayment({
            amount: msg.value,
            depositTime: block.timestamp
        });
        user.depositPayments.push(payment);

        // Change user balances
        user.totalLend += payment.amount;

        // Update global pool
        liquidityPool += payment.amount;
    }
}
