// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ISwappableToken is IERC20 {
    function approve(
        address owner,
        address spender,
        uint256 amount
    ) external returns (bool);
}
