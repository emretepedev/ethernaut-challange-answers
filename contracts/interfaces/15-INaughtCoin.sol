// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface INaughtCoin is IERC20 {
    function timeLock() external view returns (uint256);

    // solhint-disable-next-line func-name-mixedcase
    function INITIAL_SUPPLY() external view returns (uint256);

    function player() external view returns (address);

    function transfer(address _to, uint256 _value)
        external
        override
        returns (bool);
}
