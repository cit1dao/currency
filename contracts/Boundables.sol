//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

// TODO: do we need to prevent circular imports?

// this represents a thing that can be bounded by a Boundary/BoundableRegistry
interface Boundable {

}

abstract contract BoundableRegistry {

    mapping(address => bool) public registered;

    Boundable _template;

    // constructor
    function __BoundableRegistry_init(
        Boundable _template
    ) public {
        template = _template;
    }

    function register() external {
        // TODO: checks if approved by authority
        address instance = ClonesUpgradeable.clone(
            address(_template)
        );

        // set the address of our new implementation as verified by factory
        registered[instance] = true;
    }

    function isRegistered(address _dest) public view returns (bool) {
        return registered[_dest];
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

    /**
     * @dev Constructor for determining allowed functionality
     */
    function __Boundary_init(
        BoundableRegistry _citizens,
        BoundableRegistry _purchasables,
        BoundableRegistry _fundables
    ) public initializer {
        __Context_init_unchained();

        citizens = BoundableRegistry(_citizens);
        purchasables = BoundableRegistry(_purchasables);
        fundables = BoundableRegistry(_fundables);
    }

    // the "_source" does not matter, because the subclass determines which functionality to allow.
    function checkTokenTransfer(address _dest) {
        if (isFundable(_dest)) {
            return checkFund();
        } else if (isPurchasable(_dest)) {
            return checkPurchase();
        } else if (isEmployable(_dest)){
            // TODO: We need to figure out how monthly paychecks can get around this
            // TODO: We're basically saying that citizens can't receive anything - is that right?
            return checkEmployable();
        } else {
            return checkTrade();
        }
    }

    function isPurchasable(address dest) {
        return BoundableRegistry(purchasables).isRegistered(dest);
        //        return PurchasableRegistry(purchasables).isRegistered(dest);  // TODO: can we circular import?
    }

    function isFundable(address _dest) {
        return BoundableRegistry(fundables).isRegistered(_dest);
        //        return FundableRegistry(fundables).isRegistered(_dest);  // TODO: can we circular import?
    }

    function isEmployable(address _dest) {
        return BoundableRegistry(citizens).isRegistered(_dest);
        //        return CitizenRegistry(citizens).isRegistered(_dest);  // TODO: can we circular import?
    }

    function checkEmployable() {
        return false;   // authorized for payroll
    }
    function checkPurchase() {
        return false;   // cit & biz
    }
    function checkFund() {
        return false;   // gov & cit
    }
    function checkTrade() {
        return false;   // gov & biz
    }
}
