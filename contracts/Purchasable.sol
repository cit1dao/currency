//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "./Registrable.sol";

interface Purchasable is Registrable {
    // a product that can be purchased
}

contract PurchasableRegistry is Registry {

    // constructor
    function __PurchaseFactory_init(
        Purchasable _template
    ) public {
        template = _template;
    }

}
