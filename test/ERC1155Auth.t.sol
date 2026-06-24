// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {ERC1155Auth} from "../src/ERC1155Auth.sol";
import {Roles} from "../src/Roles.sol";

/// @title ERC1155AuthTest
/// @notice Test suite for validating the ERC1155Auth contract logic.
contract ERC1155AuthTest is Test {
    ERC1155Auth public erc1155Auth;

    address public constant admin = address(0x123);
    address public constant minter = address(0x456);
    address public constant manager = address(0x789);
    address public constant user1 = address(0xabc);
    address public constant user2 = address(0xdef);

    /// @notice Sets up the testing environment before each test execution.
    function setUp() public {
        vm.startPrank(admin);
        erc1155Auth = new ERC1155Auth();
        erc1155Auth.grantRole(Roles.MINTER_ROLE, minter);
        erc1155Auth.grantRole(Roles.MENEGER_ROLE, manager);
        vm.stopPrank();
    }

    /// @notice Verifies that the contract deploys successfully and roles are correctly granted.
    function testDeployment() public view{
        assert(address(erc1155Auth) != address(0));
        assertTrue(erc1155Auth.hasRole((erc1155Auth.DEFAULT_ADMIN_ROLE()), admin));
        assertTrue(erc1155Auth.hasRole(Roles.MINTER_ROLE, minter));
        assertTrue(erc1155Auth.hasRole(Roles.MENEGER_ROLE, manager));

        console.log("ERC1155Auth", address(erc1155Auth));
    }

    /// @notice Tests the minting process for a new token.
    function testMint() public{
        vm.startPrank(minter);
        string memory tokenUri = "https://example.com/token/1";
        erc1155Auth.mint(user1, 10, tokenUri);
        vm.stopPrank();

        assertEq(erc1155Auth.balanceOf(user1, 0), 10);
        assertEq(erc1155Auth.uri(0), tokenUri);
    }

    /// @notice Tests the functionality to update an existing token URI.
    function testUpdateTokenUri() public{
        testMint();

        vm.startPrank(manager);
        string memory newTokenUri = "https://example.com/newTokenUri/2";
        erc1155Auth.updateUri(0, newTokenUri);
        vm.stopPrank();

        assertEq(erc1155Auth.uri(0), newTokenUri);
    }

    /// @notice Tests the hasToken function to verify token possession.
    function testHasToken() public {
        testMint();
        
        assertTrue(erc1155Auth.hasToken(user1, 0));
    }
}