// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {IERC1155Auth} from "./IERC1155Auth.sol";
import {Roles} from "./Roles.sol";

contract ERC1155Auth is ERC1155, AccessControl, IERC1155Auth {

    constructor() ERC1155("000") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    mapping(uint256 => string) private _tokenURIs;

    uint256 public currentTokenId = 0;

    function hasToken(address _user, uint256 _tokenId) external view returns (bool) {
        return balanceOf(_user, _tokenId) > 0;
    }

    function mint(address account, uint256 amount, string memory _tokenURI)public onlyRole(Roles.MINTER_ROLE){
        uint256 newTokenId = currentTokenId;
        currentTokenId++;

        _mint(account, newTokenId, amount, "");

        _tokenURIs[newTokenId] = _tokenURI;
    }

    function updateUri(uint256 _tokenId, string memory _newTokenURI) external onlyRole(Roles.MENEGER_ROLE) {
        _tokenURIs[_tokenId] = _newTokenURI;
    }


    function uri(uint256 _tokenId) public view override returns (string memory) {
        return _tokenURIs[_tokenId];
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
