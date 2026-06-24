// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0

pragma solidity ^0.8.35;

import {IERC1155Auth} from "./IERC1155Auth.sol";

/// @title AuthTest
/// @notice A contract to test participation based on token ownership.
contract AuthTest {
    /// @notice Instance of the IERC1155Auth interface.
    IERC1155Auth public auth;

    /// @notice Mapping to track participation status of users.
    mapping(address => bool) participations;

    /// @notice Constructor to initialize the auth contract address.
    /// @param _authAddress The address of the IERC1155Auth contract.
    constructor(address _authAddress) {
        auth = IERC1155Auth(_authAddress);
    }

    /// @notice Custom error thrown when the user lacks the required token.
    error UserDontHaveToken(uint256 _tokenID);

    /// @notice Allows a user to participate if they hold the required token.
    /// @dev Checks token balance using the auth contract.
    function participate() external {
        require(auth.hasToken(msg.sender, 1), UserDontHaveToken(1));
        participations[msg.sender] = true;
    }
}