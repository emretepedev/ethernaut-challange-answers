// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IMagicNum.sol";

/**
 * @title MagicNum Attack (Ethernaut Challenge Level 18 - MagicNumber)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 18
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x200d3d9Ac7bFd556057224e7aEB4161fED5608D0
 * @custom:security-contact emretepedev@gmail.com
 */
contract MagicNumAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @dev Solver's bytecode is 0x600a600c600039600a6000f3602a60505260206050f3
     * @param target Address of target contract
     */
    function attack(IMagicNum target, bytes memory bytecode) external {
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

        target.setSolver(solver);

        require(solver == target.solver(), "MagicNum: Attack failed");
    }
}
