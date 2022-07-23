// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./support/interfaces/IOwnable.sol";
import "./support/interfaces/IDetectionBot.sol";
import "./support/interfaces/IForta.sol";

interface IDoubleEntryPoint is IERC20, IOwnable {
    function cryptoVault() external view returns (address);

    function player() external view returns (address);

    function delegatedFrom() external view returns (address);

    function forta() external view returns (IForta);

    function delegateTransfer(
        address to,
        uint256 value,
        address origSender
    ) external returns (bool);
}
