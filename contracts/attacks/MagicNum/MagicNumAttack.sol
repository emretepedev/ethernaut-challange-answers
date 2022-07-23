// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IMagicNum.sol";

contract MagicNumAttack {
    IMagicNum private immutable victimMagicNum;

    constructor(IMagicNum victimMagicNum_) {
        victimMagicNum = victimMagicNum_;
    }

    /// @dev Solver's bytecode is 0x600a600c600039600a6000f3602a60505260206050f3
    function attack(bytes memory bytecode) external {
        address solver;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            solver := create(0, add(bytecode, 32), mload(bytecode))
            if iszero(extcodesize(solver)) {
                revert(0, 0)
            }
        }

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, bytes memory data) = solver.call(abi.encodeWithSignature("whatIsTheMeaningOfLife()"));

        require(isSuccess, "MagicNum: Call error");

        require(42 == uint256(bytes32(data)), "MagicNum: Wrong res");

        victimMagicNum.setSolver(solver);

        require(solver == victimMagicNum.solver(), "MagicNum: Attack failed");
    }
}
