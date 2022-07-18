// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/18-IMagicNum.sol";

contract MagicNumAttack {
    IMagicNum public immutable victimMagicNum;

    constructor(IMagicNum victimMagicNum_) {
        victimMagicNum = victimMagicNum_;
    }

    /// @dev solver's bytecode is 0x600a600c600039600a6000f3602a60505260206050f3
    function attack(bytes memory bytecode) external {
        address solver;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
            if iszero(extcodesize(solver)) {
                revert(0, 0)
            }
        }

        victimMagicNum.setSolver(solver);

        require(solver == victimMagicNum.solver(), "MagicNum: Attack failed");
    }
}
