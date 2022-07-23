// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPrivacy {
    function locked() external view returns (bool);

    // solhint-disable-next-line func-name-mixedcase
    function ID() external view returns (uint256);

    function unlock(bytes16 _key) external;
}
