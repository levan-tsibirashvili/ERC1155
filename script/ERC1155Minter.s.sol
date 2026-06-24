// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

/// @title ERC1155Minter
/// @notice Script to mint new tokens using the ERC1155Auth contract.
/// @dev Uses Foundry's Script library to broadcast the minting transaction.
contract ERC1155Minter is Script {

    /// @notice Executes the minting process.
    /// @dev Reads the minter private key and contract address from environment variables, 
    /// then calls the mint function on the ERC1155Auth contract.
    /// @param _to The address to which the tokens will be minted.
    /// @param _amount The quantity of tokens to be minted.
    /// @param _tokenUUri The URI string for the new token.
    function run(address _to, uint256 _amount, string memory _tokenUUri) public {
        uint256 minterPrivateKey = vm.envUint("MINTER_PRIVATE_KEY");

        vm.startBroadcast(minterPrivateKey);
        address contractAddress = vm.envAddress("ERC1155_AUTH_CONTRACT_ADDRESS");
        ERC1155Auth erc1155Auth = ERC1155Auth(contractAddress);
        erc1155Auth.mint(_to, _amount, _tokenUUri);
        console.log("token successfully minted for:", _to);
        vm.stopBroadcast();
    }
}