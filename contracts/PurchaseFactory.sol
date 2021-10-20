//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";

import "./PurchaseFactoryImplementation.sol";

contract PurchaseFactory {
    mapping(address => bool) public addressIsVetted;

    PurchaseFactoryImplementation public purchaseFactoryImplementation;

    // constructor
    function __PurchaseFactory_init(
        PurchaseFactoryImplementation _purchaseFactoryImplementation
    ) public {
        purchaseFactoryImplementation = _purchaseFactoryImplementation;
    }

    function createPurchaseFactory() external {
        // TODO: checks if approved by authority
        address purchaseFactory = ClonesUpgradeable.clone(
            address(purchaseFactoryImplementation)
        );

        // set the address of our new implementation as verified by factory
        addressIsVetted[purchaseFactory] = true;
    }

    function fromAddressIsFromFactory(address _to) public view returns (bool) {
        return addressIsVetted[_to];
    }
}
