// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0

pragma solidity ^0.8.35;

interface IERC1155Auth {
    function hasToken(address _user, uint256 _tokenId) external view returns (bool);
    function updateUri(uint256 _tokenId, string memory _newTokenURI) external;

}