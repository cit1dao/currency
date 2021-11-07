pragma solidity >=0.4.22 <0.9.0;

import "./Boundable.sol";


// cloning a Product is one thing, but a Citizen?
interface Tradable is Boundable {
    // this can be paid UUSD
}

/**
 * TODO: I'm not sure what it means for "BoundableRegistry" to be able to "clone" a Citizen?
 * Keeps track of wallets that can be paid payroll (receive Cits)
 */
contract TradableRegistry is BoundableRegistry {

    // constructor
    function __TradableRegistry_init(
        Tradable _template
    ) public {
        __BoundableRegistry_init(_template);
    }

}
