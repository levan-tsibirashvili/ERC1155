// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {script} from "forge-std/Script.sol";

import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";


contract ERC1155Minter is Script {

    function run(address _to, uint256 _amount, string memory _tokenUUri) public {
        // minterPrivateKey - ეს არის პირადი გასაღების მნიშვნელობა, რომელიც გამოიყენება ტრანზაქციების ხელმოწერისთვის,
        // ამ შემთხვევაში ჩვენ ვიყენებთ მისამართს რომელიც გამოიყენება როლის მინიჭებისთვის.
        // და ვანიჭებთ მას როლს MINTER_ROLE, რათა ეს მისამართი შეძლოს მინტინგის ფუნქციების გამოყენება.
        uint256 minterPrivateKey = vm.envUint("MINTER_PRIVATE_KEY");

        vm.startBroadcast(minterPrivateKey);

        // vm.envAddress ფუნქცია არის Forge-ის ნაწილი, რომელიც საშუალებას გვაძლევს სტრინგი "ERC1155_AUTH_CONTRACT_ADDRESS" გარდაიქმნას address ტიპში.
        address contractAddress = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS");

        ERC1155Auth erc1155Auth = ERC1155Auth(contractAddress);

        erc1155Auth.mint(_to, _amount, _tokenUUri);

        console.log("token successfully minted for:", _to);

        vm.stopBroadcast();
    }

}