//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

import "./Factory.sol";

/**
 * @title Cit1Currency
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 */
contract Cit1Currency is Initializable, ContextUpgradeable, ERC20Upgradeable {
    PurchaseFactory purchaseFactory;

    /**
     * @dev Constructor that gives _msgSender() all of existing tokens.
     */
    function __Cit1Currency_init(
        string memory name,
        string memory symbol,
        Factory _factory
    ) public initializer {
        __Context_init_unchained();
        __ERC20_init_unchained(name, symbol);
        _mint(_msgSender(), 10000 * (10**uint256(decimals())));
        factory = Factory(_factory);
    }

    function _checkAddressIsVetted(address _to) public view returns (bool) {
        bool isVetted;
        (isVetted) = Factory(factory).fromAddressIsFromFactory(_to);
        return isVetted;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        require(
            _checkAddressIsVetted(to),
            "address not purchase contract or fund contract"
        );
        super._beforeTokenTransfer(from, to, value);
    }
}
