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

// როდესაც ვიყენებთ .env ფუნქციას მაშინ აუცილებელია მასთან ზემოქმედებისთვის აუცილებელია თავად env-ის შექმნა მთავარ საქაღალდეში (სადაც არის src, test, script ფაილები)
// .env ფაილის სახით, სადაც გადავცემთ ყველა არსებულ გარემოს ცვლადს, მაგალითად DEPLOYER_PRIVATE_KEY=0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef123456789

// დეტალურად ERC1155AuthDeploy.s.sol-ში, რადგან აქ იგივე პრინციპები მოქმედებს.


// ამ სკრიპტის გაშვებისთვის და ბლოკჩეინში განთავსებისთვის, ჩვენ უნდა გამოიყენოთ შემდეგი ბრძანება ტერმინალში:

// forge script script/ERC1155GrantMinterRole.s.sol:ERC1155GrantMinterRole --broadcast --rpc-url https://sepolia.base.org --sig "run(address)" 0xAfd378303EaF596FE90e994B87A55E1ef9eEBdBd

// რადგან არ ვახდენთ კონტრაქტის დეპლოის, შესაბამისად არ გვჭირდება --verify პარამეტრი,
// ჩვენ უბრალოდ ვიძახებთ უკვე განთავსებულ კონტრაქტს და ვახდენთ მინტინგის ფუნქციის გამოყენებას.


// --sig "run(address)" ეს არის ფუნქციის სიგნატურა, რომელიც მიუთითებს, რომ ჩვენ ვიძახებთ run ფუნქციას, რომელსაც აქვს ერთი პარამეტრი address.
// address - 0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef123456789 - ეს არის roleAddress მისამართი, რომლისთვისაც გვინდა როლის მინიჭება
