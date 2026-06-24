// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

/// @title ERC1155AuthDeploy
/// @notice Deployment script for the ERC1155Auth contract.
/// @dev Uses Foundry's Script library to broadcast the deployment transaction.
contract ERC1155AuthDeploy is Script {

    /// @notice Executes the deployment logic.
    /// @dev Reads the deployer private key from environment variables and broadcasts the deployment of ERC1155Auth.
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        ERC1155Auth erc1155Auth = new ERC1155Auth();
        console.log("ERC1155Auth deployed at:", address(erc1155Auth));        
        vm.stopBroadcast();
    }
}