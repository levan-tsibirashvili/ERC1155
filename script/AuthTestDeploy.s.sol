// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {AuthTest} from "../src/AuthTest.sol";

contract AuthTestDeploy is Script {
    function run() public {
            uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

            //ვიღებთ .env ფაილიდან ჩვენი კონტრაქტის მისამართს
            address erc1155auth = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS")

            vm.startBroadcast(deployerPrivateKey);

            AuthTest auth = new AuthTest(erc1155auth);

            console.log("AuthTest deployed at:", address(auth)); 
            vm.stopBroadcast();
    }
}


// ამ სკრიპტის გაშვებისთვის და ბლოკჩეინში განთავსებისთვის, ჩვენ უნდა გამოიყენოთ შემდეგი ბრძანება ტერმინალში:

// forge script script/AuthTestDeploy.s.sol:AuthTestDeploy --broadcast --rpc-url wss://base-sepolia.drpc.org --verify --verifier etherscan --etherscan-api-key $ETHERSCAN_API_KEY
