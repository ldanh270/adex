// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Status} from '../events/Status.sol';

contract DSBank is Status {
    // Defi user
    struct User {
        uint totalLend;
        uint totalBorrow;
    }

    // Total Liquidity Pool
    uint private liquidityPool;

    // List of users
    mapping(address => User) users;

    function showPoolBalances() external view returns (uint) {
        return liquidityPool;
    }

    function deposit() external payable {
        // VALIDATE
        require((msg.value > 0), 'Deposit value must be greater than 0.');

        // DEPOSIT
        User storage user = users[msg.sender];

        // Change user balances
        user.totalLend += msg.value;

        // Update global pool
        liquidityPool += msg.value;

        // Emit notification
        emit Sucess(Method.Deposit, msg.sender, msg.value);
    }

    function withdraw(uint _amount) external payable {
        // VALIDATE
        require(_amount <= users[msg.sender].totalLend, 'Insufficient balances');

        // WITHDRAW
        User storage user = users[msg.sender];

        // Change user balances
        user.totalLend -= _amount;

        // Update global pool
        liquidityPool -= _amount;

        // Emit notification
        emit Sucess(Method.Withdraw, msg.sender, _amount);
    }
}
