// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

/// @title ERC1155GrandMinterRole
/// @notice Script to grant the MINTER_ROLE to a specific address.
/// @dev Uses Foundry's Script library to broadcast the transaction.
contract ERC1155GrandMinterRole is Script {

    /// @notice Executes the granting of the MINTER_ROLE.
    /// @dev Reads the deployer private key and contract address from environment variables, 
    /// then grants the role to the provided address.
    /// @param roleAddress The address to which the MINTER_ROLE will be granted.
    function run(address roleAddress) public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        address contractAddress = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS");
        ERC1155Auth erc1155Auth = ERC1155Auth(contractAddress);
        erc1155Auth.grantRole(Roles.MINTER_ROLE, roleAddress);
        console.log("MINTER_ROLE granted to:", roleAddress);        
        vm.stopBroadcast();
    }
}