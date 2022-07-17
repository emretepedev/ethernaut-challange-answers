// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPreservation {
    function timeZone1Library() external view returns (address);

    function timeZone2Library() external view returns (address);

    function owner() external view returns (address);

    function setFirstTime(uint256 _timeStamp) external;

    function setSecondTime(uint256 _timeStamp) external;
}
