//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";

import "./Registrable.sol";

interface Fundable is Registrable {
    // a project that can be funded
}

contract FundableRegistry {

    mapping(address => bool) public registered;

    Fundable public template;

    // constructor
    function __PurchaseFactory_init(
        Fundable _template
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
