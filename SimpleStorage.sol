// SPDX-License-Identifier: MIT
// pragma solidity 0.8.8; // versione specifica da utilizzare
pragma solidity ^0.8.7; // dalla 0.8.7 in su

// pragma solidity >=0.8.7 <0.9.0; // compreso tra la 0.8.7 e la 0.9.0

// EVM, Ethereum Virtual Machine
// Avalanche, Fantom, Polygon

contract SimpleStorage {
   // bool, uint, int, address, bytes
   uint256 favoriteNumber;
   //People person = People({favoriteNumber: 3, name: "Patrick"});

   mapping(string => uint256) public nameToFavoriteNumber;

   struct People {
      uint256 favoriteNumber;
      string name;
   }

   // uint256[] public favoriteNumbersList;
   People[] public people;

   function store(uint256 _favoriteNumber) public virtual {
      favoriteNumber = _favoriteNumber;
   }

   // view, pure
   // view and pure functions disallow modification
   // of the state (of the blockchain)
   // pure functions additionally disallow
   // you to read from blockchain state
   // == u can't update the blockchain AT ALL with
   // a view function
   function retrieve() public view returns (uint256) {
      return favoriteNumber;
   }

   // pure example
   //function add() public pure returns(uint256) {
   //    return (1+1);
   //}

   // in general, we only spend gas (we only make a transaction)
   // when we modify the state of the blockchain

   // if a gas calling function calls a view or pure function
   // then IT WILL COST GAS

   // calldata, memory, storage
   // calldata -> temp var, can't be modified
   // memory -> temp var, CAN be modified
   // storage -> permanent var, CAN be modified
   function addPerson(string memory _name, uint256 _favoriteNumber) public {
      // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
      // People memory newPerson = People(_favoriteNumber, _name);
      //people.push(newPerson);
      people.push(People(_favoriteNumber, _name));
      nameToFavoriteNumber[_name] = _favoriteNumber;
   }
}
// 0xd9145CCE52D386f254917e481eB44e9943F39138
