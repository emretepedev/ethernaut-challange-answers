// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IMagicNum.sol";

contract MagicNumAttack {
    IMagicNum public immutable victimMagicNum;

    constructor(IMagicNum victimMagicNum_) {
        victimMagicNum = victimMagicNum_;
    }

    /// @dev Solver's bytecode is 0x600a600c600039600a6000f3602a60505260206050f3
    function attack(bytes memory bytecode) external {
        address solver;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
            if iszero(extcodesize(solver)) {
                revert(0, 0)
            }
        }

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, bytes memory data) = solver.call(
            abi.encodeWithSignature("whatIsTheMeaningOfLife()")
        );

        require(isSuccess, "MagicNum: Call error");

        uint256 theMeaningOfLife;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            theMeaningOfLife := mload(add(add(data, 0x20), 0))
        }

        require(42 == theMeaningOfLife, "MagicNum: Wrong res");

        victimMagicNum.setSolver(solver);

        require(solver == victimMagicNum.solver(), "MagicNum: Attack failed");
    }
}
