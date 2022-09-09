// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRecovery {
    function generateToken(string memory _name, uint256 _initialSupply) external;
}
