//SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts-upgradeable/proxy/ClonesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

import "./Boundable.sol";

contract BoundedCoin is Initializable, ContextUpgradeable, ERC20Upgradeable {

    Boundary boundary;

    function __BoundedCoin_init(
        Boundary _boundary
    ) public initializer {
        __Context_init_unchained();

        boundary = _boundary;
    }

    function _checkTokenTransfer(address _from, address _to, uint256 _value) public view returns (bool) {
        return Boundary(boundary).checkTokenTransfer(_from, _to, _value);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual override {
        require(
            _checkTokenTransfer(from, to, value),
            "address not purchase contract or fund contract"
        );
        super._beforeTokenTransfer(from, to, value);
    }
}
