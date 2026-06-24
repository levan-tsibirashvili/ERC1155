// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0

pragma solidity ^0.8.35;

/// @title IERC1155Auth
/// @notice Interface for authentication and management methods.
/// @dev Defines the external functions for checking token ownership and updating URIs.
interface IERC1155Auth {
    /// @notice Checks if a user holds a specific token ID.
    /// @param _user The address of the user.
    /// @param _tokenId The ID of the token.
    /// @return bool Returns true if the user balance is greater than 0, otherwise false.
    function hasToken(address _user, uint256 _tokenId) external view returns (bool);

    /// @notice Updates the URI for a specific token ID.
    /// @param _tokenId The ID of the token.
    /// @param _newTokenURI The new URI to be assigned.
    function updateUri(uint256 _tokenId, string memory _newTokenURI) external;
}