// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDoubleEntryPoint.sol";

/**
 * @title DoubleEntryPoint Defend (Ethernaut Challenge Level 26 - DoubleEntryPoint)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 26
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x128BA32Ec698610f2fF8f010A7b74f9985a6D17c
 * @custom:security-contact emretepedev@gmail.com
 */
contract DoubleEntryPointDefend is IDetectionBot {
    IDoubleEntryPoint private immutable target;

    /**
     * @param target_ Address of target contract
     */
    constructor(IDoubleEntryPoint target_) {
        target = target_;
    }

    /*//////////////////////////////////////////////////////////////
                                Defend
    //////////////////////////////////////////////////////////////*/

    /**
    * @dev To set the detection bot, you can run this script in browser:
        > await web3.eth.sendTransaction({
            to: await contract.forta(),
            from: player,
            data: web3.eth.abi.encodeFunctionCall(
                {
                name: 'setDetectionBot',
                type: 'function',
                inputs: [
                    {
                    type: 'address',
                    name: 'detectionBotAddress'
                    }
                ]
                },
                [<DETECTION_BOT_CONTRACT_ADDRESS>]
            )
        });
    * @param user Address of the user
    * @param msgData Calldata of the transaction
    */
    function handleTransaction(address user, bytes calldata msgData) external override {
        IForta forta = target.forta();

        require(msg.sender == address(forta), "DoubleEntryPoint: Unauthorized");

        if (bytes4(abi.encodeWithSelector(target.delegateTransfer.selector)) == bytes4(msgData)) {
            forta.raiseAlert(user);
        }
    }
}
