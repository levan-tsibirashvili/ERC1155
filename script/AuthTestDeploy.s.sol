// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {AuthTest} from "../src/AuthTest.sol";

/// @title AuthTestDeploy
/// @notice Deployment script for the AuthTest contract.
/// @dev Uses Foundry's Script library to broadcast the deployment transaction.
contract AuthTestDeploy is Script {
    /// @notice Executes the deployment logic.
    /// @dev Reads private key and contract address from environment variables, then broadcasts the deployment.
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address erc1155auth = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);
        AuthTest auth = new AuthTest(erc1155auth);
        console.log("AuthTest deployed at:", address(auth)); 
        vm.stopBroadcast();
    }
}