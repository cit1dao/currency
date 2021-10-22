pragma solidity >=0.4.22 <0.9.0;

import "./Boundable.sol";


// cloning a Product is one thing, but a Citizen?
interface Earnable is Boundable {
    // this can be paid UUSD
}

/**
 * Determines who gets UBI (Citizens)
 */
contract EarnableRegistry is BoundableRegistry {

    // constructor
    function __EmployableRegistry_init(
        Earnable _template
    ) public {
        __BoundaryRegistry_init(_template);
    }

}
