// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Status {
    enum Method {
        Deposit,
        Withdraw
    }

    event Sucess(Method _method, address _user, uint _amount);
    event Failure(Method _method, address _user, uint _amount);
}
