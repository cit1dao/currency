# Currency

This project contains the currency logic for `Cit1`

## Currencies

 - [x] Cits
 - [ ] Govs
 - [ ] UUSD

### Boundaries
 
| Currency      | Registry              | Boundary              | Functionality         |
| ------------- | -------------         | --------              | ---------------------
| Cits          | EmployableRegistry    | CitizenBoundary       | Earn, Fund, Purchase  |
| Govs          | FundableRegistry      |                       | Trade, Fund           |
| UUSD          | PurchasableRegistry   |                       | Trade, Purchase       |

#### Models

 - `abstract BoundedCoin` - enables restrictions on functionality of a coin.
   - `Cits` - usable by citizens (not Gov or Biz)
 - `interface Registrable` - the ability to sit in a registry
   - `abstract contract Registry` - abstract superclass for registering things.
 - `interface Boundable` - the ability to enforce functionality
   - `abstract contract BoundableRegistry` - the registry for things that can be bounded.
 - `interface Fundable` - an address that can receive Cits/Govs
   - `contract FundableRegistry` - keeps track of what can be funded (receive Cits/Govs)
 - `interface Purchasable` - an address that can receive Cits/UUSD
   - `contract PurchasableRegistry` - keeps track of what can be purchased (receive Cits/UUSD).
 - `interface Employable` - a Citizens ability to work (receive Cits from UUSD deposits)
   - `contract EmployableRegistry` - keeps track of who is able to work.

## Getting started:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node

node scripts/sample-script.js

npx hardhat help
```
