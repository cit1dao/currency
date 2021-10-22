import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";

interface Registrable {
    // a thing that can be registered
}

//
// a registry
//              makes stuff (proxies to a template)
//              keeps track (of what it makes)
abstract contract Registry {

    mapping(address => bool) public registered;

    Registrable public template;

    // constructor
    function __Registry_init(
        Registrable _template
    ) public {
        template = _template;
    }

    // TODO: check if approved by authority
    // TODO: should we have a
    function createOne() external {
        address instance = ClonesUpgradeable.clone(
            address(template)
        );

        // set the address of our new implementation as verified by factory
        registered[instance] = true;
    }

    // opportunity to let the subclass enforce any custom enrollment rules.
    function _exec_registration(address registration) {
//        assert(false, "subclass must implement this");
    }

    function isRegistered(address _destination) public view returns (bool) {
        return registered[_destination];
    }
}
