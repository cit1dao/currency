//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "./Boundables.sol";
import "./Purchasable.sol";
import "./Fundable.sol";
import "./Employable.sol";
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
        FundableRegistry _fundables
    ) public initializer {
        __Context_init_unchained();
        __Boundary_init(_citizens, _purchasables, _fundables);
    }

    function checkTrade() {
        return false;
    }
}

/**
 * @title Cit1Currency
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 */
contract Cits is BoundedCoin {

    /**
     * @dev Constructor that gives _msgSender() all of existing tokens.
     */
    function __Cits_init(
        CitizenBoundary _boundary       // this determines what a Citizen can do.
    ) public initializer {
        __Context_init_unchained();
        __ERC20_init_unchained("Citizen Coin", "Cits");
        __BoundedCoin_init(_boundary);
        _mint(_msgSender(), 10000 * (10**uint256(decimals())));
    }

}
