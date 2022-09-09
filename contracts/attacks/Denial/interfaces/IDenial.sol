// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDenial {
    function partner() external view returns (address);

    function owner() external view returns (address payable);

    function setWithdrawPartner(address _partner) external;

    function withdraw() external;

    function contractBalance() external view returns (uint256);

    receive() external payable;
}
