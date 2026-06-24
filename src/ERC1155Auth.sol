// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {IERC1155Auth} from "./IERC1155Auth.sol";
import {Roles} from "./Roles.sol";

/// @title ERC1155Auth
/// @author Levan Tsibirashvili
/// @notice This contract manages ERC1155 tokens with role-based access control.
/// @dev Inherits from ERC1155, AccessControl, and IERC1155Auth.
contract ERC1155Auth is ERC1155, AccessControl, IERC1155Auth {

    /// @notice Constructor that sets the initial URI and grants the default admin role to the deployer.
    constructor() ERC1155("000") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /// @dev Mapping that stores the URI for each token ID.
    mapping(uint256 => string) private _tokenURIs;

    /// @notice Current token ID tracker that increments with each minting.
    uint256 public currentTokenId = 0;

    /// @notice Checks if a user owns a specific token ID.
    /// @param _user The address of the user.
    /// @param _tokenId The ID of the token.
    /// @return bool True if the balance is greater than zero, false otherwise.
    function hasToken(address _user, uint256 _tokenId) external view returns (bool) {
        return balanceOf(_user, _tokenId) > 0;
    }

    /// @notice Mints new tokens.
    /// @dev Only accounts with MINTER_ROLE can call this function.
    /// @param account The receiving address.
    /// @param amount The quantity of tokens.
    /// @param _tokenURI The URI address for the token.
    function mint(address account, uint256 amount, string memory _tokenURI) public onlyRole(Roles.MINTER_ROLE){
        uint256 newTokenId = currentTokenId;
        currentTokenId++;

        _mint(account, newTokenId, amount, "");

        _tokenURIs[newTokenId] = _tokenURI;
    }

    /// @notice Updates the URI for an existing token.
    /// @dev Only accounts with MENEGER_ROLE can call this function.
    /// @param _tokenId The token ID.
    /// @param _newTokenURI The new URI address.
    function updateUri(uint256 _tokenId, string memory _newTokenURI) external onlyRole(Roles.MENEGER_ROLE) {
        _tokenURIs[_tokenId] = _newTokenURI;
    }

    /// @notice Returns the URI for a token ID.
    /// @param _tokenId The token ID.
    /// @return string The token URI.
    function uri(uint256 _tokenId) public view override returns (string memory) {
        return _tokenURIs[_tokenId];
    }

    // The following functions are overrides required by Solidity.

    /// @notice Checks support for implemented interfaces.
    /// @param interfaceId The interface ID.
    /// @return bool True if the interface is supported.
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}