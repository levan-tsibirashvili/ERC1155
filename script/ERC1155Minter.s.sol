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

// როდესაც ვიყენებთ env ფუნქციას მაშინ აუცილებელია მასთან ზემოქმედებისთვის აუცილებელია თავად env-ის შექმნა მთავარ საქაღალდეში (სადაც არის src, test, script ფაილები)
// .env ფაილის სახით, სადაც გადავცემთ ყველა არსებულ გარემოს ცვლადს, მაგალითად DEPLOYER_PRIVATE_KEY=0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef123456789

// დეტალურად ERC1155AuthDeploy.s.sol-ში, რადგან აქ იგივე პრინციპები მოქმედებს.


// ამ სკრიპტის გაშვებისთვის და ბლოკჩეინში განთავსებისთვის, ჩვენ უნდა გამოიყენოთ შემდეგი ბრძანება ტერმინალში:

// forge script script/ERC1155Minter.s.sol:ERC1155Minter --broadcast --rpc-url https://etherscan.io/login?cmd=last --sig "run(address,uint256,string)" 0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef123456789 10 "https://example.com/token/1"

// რადგან არ ვახდენთ კონტრაქტის დეპლოის, შესაბამისად არ გვჭირდება --verify პარამეტრი,
// ჩვენ უბრალოდ ვიძახებთ უკვე განთავსებულ კონტრაქტს და ვახდენთ მინტინგის ფუნქციის გამოყენებას.



// forge script ბრძანება გამოიყენება სკრიპტების გაშვებისთვის,

// შემდეგ უნდა მივუთითოთ სკრიპტის ფაილის სახელი, მაგალითად: script/ERC1155Minter.s.sol:ERC1155Minter
// script/ERC1155Minter.s.sol - ეს არის სკრიპტის ფაილის სახელი, რომელიც შეიცავს ERC1155Minter კონტრაქტს.
// :ERC1155Minter - ეს არის კონტრაქტის სახელი, რომელიც უნდა შესრულდეს.

// --broadcast პარამეტრი მიუთითებს, რომ ტრანზაქციები უნდა გაიგზავნოს ბლოკჩეინზე, და არა მხოლოდ სიმულაციაში. ეს არის აუცილებელი,
// რადგან ჩვენ გვინდა, რომ ჩვენი კონტრაქტი რეალურად განთავსდეს ბლოკჩეინზე და იყოს ხელმისაწვდომი სხვა მომხმარებლებისთვის.

// --rpc-url https://etherscan.io/login?cmd=last - ეს არის ბლოკჩეინთან დაკავშირების URL, რომელიც შეიძლება იყოს Infura ან Alchemy სერვისის URL.

// --sig "run(address,uint256,string)" - ეს არის ფუნქციის სიგნატურა, რომელიც მიუთითებს, რომ ჩვენ ვიძახებთ run ფუნქციას, რომელსაც აქვს სამი პარამეტრი: address, uint256 და string.
// address - 0x123456789abcdef123456789abcdef123456789abcdef123456789abcdef123456789 - ეს არის _to პარამეტრის მნიშვნელობა, ტოკენის მიმღების მისამართი.
// uint256 - 10 - ეს არის _amount პარამეტრის მნიშვნელობა, რომელიც მიუთითებს მინტინგის რაოდენობას.
// string - "https://example.com/token/1" - ეს არის _tokenUUri პარამეტრის მნიშვნელობა, რომელიც მიუთითებს ტოკენის URI-ს, რომელიც შეიძლება შეიცავდეს მეტამონაცემებს ტოკენის შესახებ,
// როგორიცაა სახელი, აღწერა და სხვა ინფორმაცია. ეს URI შეიძლება იყოს IPFS ან სხვა სერვისის URL, სადაც შენახულია ტოკენის მეტამონაცემები.