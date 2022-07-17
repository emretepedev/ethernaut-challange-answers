// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IDelegation {
    function owner() external view returns (address);

    // solhint-disable-next-line payable-fallback
    fallback() external;
}
