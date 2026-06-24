// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

contract ERC1155Minter is Script {

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