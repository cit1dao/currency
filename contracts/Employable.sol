import "./Boundables.sol";

// cloning a Product is one thing, but a Citizen?
interface Employable is Boundable {
    // this should hold cits (on-chain wallet)?
}

/**
 * TODO: I'm not sure what it means for "BoundableRegistry" to be able to "clone" a Citizen?
 */
contract EmployableRegistry is BoundableRegistry {

    // constructor
    function __EmployableRegistry_init(
        Employable _template
    ) public {
        __BoundaryRegistry_init(_template);
    }

}
