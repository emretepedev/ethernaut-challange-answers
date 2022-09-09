// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFallback {
    function contributions(address) external view returns (uint256);

    function owner() external view returns (address payable);

    function contribute() external payable;

    function getContribution() external view returns (uint256);

    function withdraw() external;

    receive() external payable;
}
