// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IKing {
    function prize() external view returns (uint256);

    function owner() external view returns (address payable);

    function _king() external view returns (address payable);

    receive() external payable;
}
