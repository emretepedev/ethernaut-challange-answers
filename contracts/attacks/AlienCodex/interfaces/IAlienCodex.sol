// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../../common/interfaces/IOwnable.sol";

interface IAlienCodex is IOwnable {
    function contact() external view returns (bool);

    function codex() external view returns (bytes32[] memory);

    // solhint-disable-next-line func-name-mixedcase
    function make_contact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;
}
