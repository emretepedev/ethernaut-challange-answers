// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IShop {
    function price() external view returns (uint256);

    function isSold() external view returns (bool);

    function buy() external;
}
