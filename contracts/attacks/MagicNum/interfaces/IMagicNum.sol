// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMagicNum {
    function solver() external view returns (address);

    function setSolver(address _solver) external;
}
