// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {AuthTest} from "../src/AuthTest.sol";

contract AuthTestDeploy is Script {
    function run() public {
            uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
            address erc1155auth = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS")

            vm.startBroadcast(deployerPrivateKey);
            AuthTest auth = new AuthTest(erc1155auth);
            console.log("AuthTest deployed at:", address(auth)); 
            vm.stopBroadcast();
    }
}