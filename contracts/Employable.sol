pragma solidity >=0.4.22 <0.9.0;

import "./Boundable.sol";


// cloning a Product is one thing, but a Citizen?
interface Employable is Boundable {
    // this can be paid UUSD
}

/**
 * TODO: I'm not sure what it means for "BoundableRegistry" to be able to "clone" a Citizen?
 * Keeps track of wallets that can be paid payroll (receive Cits)
 */
contract EmployableRegistry is BoundableRegistry {

    // constructor
    function __EmployableRegistry_init(
        Employable _template
    ) public {
        __BoundaryRegistry_init(_template);
    }

}
