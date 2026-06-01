// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

// ეს არის მარტივი სკრიპტი, რომელიც გამოიყენება ERC1155Auth კონტრაქტის დეპლოისთვის.
// ეს სკრიპტი შეიძლება გამოყენებულ იქნას Forge-ის ან სხვა მსგავსი ინსტრუმენტების საშუალებით, რათა სწრაფად და მარტივად განახორციელოთ კონტრაქტის დეპლოი.
import {script} from "forge-std/Script.sol";

import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";


contract ERC1155AuthDeploy is Script {

    // run ფუნქცია არის სკრიპტის მთავარი ფუნქცია, რომელიც ავტომატურად იწარმოება და შესრულდება, როდესაც სკრიპტი გაშვებულია.
    // ეს არის ფუნქცია, რომელიც შესრულდება სკრიპტის გაშვებისას და რეკომენდირებული სახელი იყოს run, რადგან ეს არის სტანდარტული სახელწოდება, რომელიც გამოიყენება Forge-ის სკრიპტებში.
    function run() public {
        // აქ ჩვენ ვახდენთ პირადი გასაღების (private key) მნიშვნელობა წარმოვადგინოთ როგორც uint256.
        // "DEPLOYER_PRIVATE_KEY" ეს არის პირადი გასაღების სახელწპდება.
        // vm.envUint ფუნქცია არის Forge-ის ნაწილი, რომელიც საშუალებას გვაძლევს სტრინგი "DEPLOYER_PRIVATE_KEY" გარდაიქმნას uint256 ტიპში.
        // ანუ vm.env ახდენს გარემოს ცვლადიდან "DEPLOYER_PRIVATE_KEY" მნიშვნელობას და გარდაიქმნება ის როგორ uint256 ტიპად
        // ასევე შეიძლება გამოყენებულ იქნას vm.envAddress, vm.envString და ა.შ. სხვადასხვა ტიპების გარდაქმნისთვის.
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        // vm.startBroadcast ფუნქცია არის Forge-ის ნაწილი, რომელიც იწყებს ტრანზაქციების გაშვებას ბლოკჩეინზე, და მას გადაეცემა პირადი გასაღების მნიშვნელობა,
        // რომელიც გამოიყენება ტრანზაქციების ხელმოწერისთვის.
        vm.startBroadcast(deployerPrivateKey);

        // ეს არის ფუნქცია, რომელიც შესრულდება სკრიპტის გაშვებისას და ვქმნით ახალ ERC1155Auth კონტრაქტის.
        ERC1155Auth erc1155Auth = new ERC1155Auth();

        console.log("ERC1155Auth deployed at:", address(erc1155Auth));
        vm.stopBroadcast();
    }

}