//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./Boundable.sol";
import "./Employable.sol";
import "./Purchasable.sol";
import "./Fundable.sol";
import "./BoundedCoin.sol";

/**
 * @title CitizenBoundary
 * @dev Determines what a Citizen can do.
 */
contract CitizenBoundary  is Boundary {

    /**
     * @dev Citizens can buy, fund, but not trade.
     */
    function __CitizenBoundary_init(
        EmployableRegistry _citizens,
        PurchasableRegistry _purchasables,
        FundableRegistry _fundables,
        TradableRegistry _tradables
    ) public initializer {
        __Context_init_unchained();
        __Boundary_init(_citizens, _purchasables, _fundables, _tradables);
    }

    function checkEmploy() { // means we can have jobs
        // TODO: how do we do a check on expiration of an address we don't know?
        return true;
    }

    function checkEarn() { // means we can receive UBI
        return true;
    }

    function checkTrade() { // means we can trade with others
        return false;
    }
}

/**
 * @title Cits
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 */
contract Cits is BoundedCoin {

    /**
     * @dev Constructor that gives _msgSender() all of existing tokens.
     */
    function __Cits_init(
        CitizenBoundary _boundary       // this determines what a Citizen can do.
    ) public initializer {
//        __Context_init_unchained(); // is the superclass enough for this?
        __ERC20_init_unchained("Citizen Coin", "Cits");
        __BoundedCoin_init(_boundary);
        _mint(_msgSender(), 10000 * (10**uint256(decimals()))); // TODO: we need to "mint" a Cits, from a UUSD
    }

}
