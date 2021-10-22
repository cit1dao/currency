pragma solidity >=0.4.22 <0.9.0;

import "./Boundable.sol";


interface Fundable is Boundable {
    // a project that can be funded
}


/**
 * @title FundableRegistry
 * @dev Keeps track of things that can be Funded (Government Projects)
 */
contract FundableRegistry is Registry {

    // constructor
    function __FundableRegistry_init(
        Fundable _template
    ) public {
        __Registry_init(_template);
    }

}
