//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

// TODO: do we need to prevent circular imports?
import "./Registrable.sol";

interface Boundable is Registrable {
    // a thing that can be used as a Boundary
}

// a registry for things that can be Bounded (BoundedCoin/Fundable/Purchasable)
abstract contract BoundableRegistry is Registry {

    // constructor
    function __BoundableRegistry_init(
        Boundable _template
    ) public {
        __Registry_init(_template);
    }

}

/**
 * @title Boundary
 * @dev Determines what an entity can do.
 */
abstract contract Boundary is Initializable, ContextUpgradeable {

    BoundableRegistry purchasables;
    BoundableRegistry fundables;
    BoundableRegistry citizens;
    BoundableRegistry tradables;

    /**
     * @dev Constructor for determining allowed functionality
     */
    function __Boundary_init(
        BoundableRegistry _citizens,
        BoundableRegistry _purchasables,
        BoundableRegistry _fundables,
        BoundableRegistry _tradables
    ) public initializer {
        __Context_init_unchained();

        tradables = BoundableRegistry(_tradables);
        citizens = BoundableRegistry(_citizens);
        purchasables = BoundableRegistry(_purchasables);
        fundables = BoundableRegistry(_fundables);
    }

    // the "_source" does not matter, because the subclass determines which functionality to allow.
    function checkTokenTransfer(address _dest) public returns (bool) {
        if (false) {
            return false;
        } else if (isFundable(_dest)) {
            return checkFund();
        } else if (isPurchasable(_dest)) {
            return checkPurchase();
        } else if (isEarnable(_dest)) {
            return checkEarn();
        } else if (isEmployable(_dest)) {
            return checkEmploy();
        } else if (isTradeable(_dest)) {
            return checkTrade();
        } else {
            return false;
        }
    }

     function checkEmploy() public returns (bool) {
         return false;
     }

     function checkTrade() public returns (bool) {
         return false;
     }

     function checkEarn() public returns (bool) {
         return false;
     }

     function checkPurchase() public returns (bool) {
         return false;
     }

    // does this make sense? Does it make sense to check the destination wallet for trade?
    // Isn't that checking if the destination wallet is a Gov or a Biz?
    function isTradeable(address _dest) public {    // what does this even mean? Can the destination receive trades?
        return BoundableRegistry(purchasables).isRegistered(_dest);
        //        return PurchasableRegistry(purchasables).isRegistered(_dest);  // TODO: can we circular import?
    }

    function isEarnable(address _dest) public {
        return BoundableRegistry(citizens).isRegistered(_dest);
        //        return PurchasableRegistry(purchasables).isRegistered(dest);  // TODO: can we circular import?
    }

    function isPurchasable(address _dest) public {
        return BoundableRegistry(purchasables).isRegistered(_dest);
        //        return PurchasableRegistry(purchasables).isRegistered(dest);  // TODO: can we circular import?
    }

    function isFundable(address _dest) public {
        return BoundableRegistry(fundables).isRegistered(_dest);
        //        return FundableRegistry(fundables).isRegistered(_dest);  // TODO: can we circular import?
    }

    function isEmployable(address _dest) public {
        return BoundableRegistry(citizens).isRegistered(_dest);
        //        return CitizenRegistry(citizens).isRegistered(_dest);  // TODO: can we circular import?
    }

    // authorized for payroll?
    function checkEmployable() public {
        return false;
    }
    // authorized to receive UBI?
    function checkEmployable() public {
        return false;
    }
    // authorized to buy stuff?
    function checkPurchase() public {
        return false;   // cit & biz
    }
    // authorized to fund stuff?
    function checkFund() public {
        return false;   // gov & cit
    }
    // authorized to trade stuff?
    function checkTrade() public {
        return false;   // gov & biz
    }
}
