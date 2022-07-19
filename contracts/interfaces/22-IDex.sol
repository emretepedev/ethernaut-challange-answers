// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./support/IOwnable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IDex is IOwnable {
    function token1() external view returns (address);

    function token2() external view returns (address);

    function setTokens(address _token1, address _token2) external;

    // solhint-disable-next-line var-name-mixedcase
    function addLiquidity(address token_address, uint256 amount) external;

    function swap(
        address from,
        address to,
        uint256 amount
    ) external;

    function getSwapPrice(
        address from,
        address to,
        uint256 amount
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external;

    function balanceOf(address token, address account)
        external
        view
        returns (uint256);
}

interface ISwappableToken is IERC20 {
    function approve(
        address owner,
        address spender,
        uint256 amount
    ) external returns (bool);
}
