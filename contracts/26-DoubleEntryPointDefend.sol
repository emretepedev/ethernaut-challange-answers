// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/26-IDoubleEntryPoint.sol";

contract DoubleEntryPointDefend is IDetectionBot {
    IDoubleEntryPoint public immutable victimDoubleEntryPoint;

    constructor(IDoubleEntryPoint victimDoubleEntryPoint_) {
        victimDoubleEntryPoint = victimDoubleEntryPoint_;
    }

    /**
    * @dev To set the detection bot, you can run this script in client side:
        await web3.eth.sendTransaction({
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
    */
    function handleTransaction(address user, bytes calldata msgData)
        external
        override
    {
        if (
            bytes4(
                abi.encodeWithSelector(
                    victimDoubleEntryPoint.delegateTransfer.selector
                )
            ) == bytes4(msgData)
        ) {
            victimDoubleEntryPoint.forta().raiseAlert(user);
        }
    }
}
