// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {script} from "forge-std/Script.sol";

import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";


contract ERC1155GrandMinterRole is Script {

    // roleAddress - ეს არის მისამართი, რომლისთვისაც გვინდა როლის მინიჭება.
    function run(address roleAddress) public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // vm.envAddress ფუნქცია არის Forge-ის ნაწილი, რომელიც საშუალებას გვაძლევს სტრინგი "ERC1155_AUTH_CONTRACT_ADDRESS" გარდაიქმნას address ტიპში.
        address contractAddress = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS");

        ERC1155Auth erc1155Auth = ERC1155Auth(contractAddress);

        erc1155Auth.grantRole(Roles.MINTER_ROLE, roleAddress);

        console.log("MINTER_ROLE granted to:", roleAddress);

        vm.stopBroadcast();
    }

}