import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";

interface Registrable {

}

contract FundableRegistry {

    mapping(address => bool) public registered;

    Registrable public template;

    // constructor
    function __PurchaseFactory_init(
        Registrable _template
    ) public {
        template = _template;
    }

    function createOne() external {
        // TODO: checks if approved by authority
        address instance = ClonesUpgradeable.clone(
            address(template)
        );

        // set the address of our new implementation as verified by factory
        registered[instance] = true;
    }

    function isRegistered(address _destination) public view returns (bool) {
        return registered[_destination];
    }
}
