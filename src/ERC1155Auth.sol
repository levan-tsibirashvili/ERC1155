// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

// ვაკეთებთ ERC1155 ტოკენების კონტრაქტს, რომელიც იყენებს OpenZeppelin-ის AccessControl (როლებს) და ERC1155 სტანდარტებს.

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {IERC1155Auth} from "./IERC1155Auth.sol";
import {Roles} from "./Roles.sol";

contract ERC1155Auth is ERC1155, AccessControl, IERC1155Auth {

    // მოვახდინეთ როლების გადატანა Roles ბიბლიოთეკაში, თავისივე ახსნის კომენტარებით.

    // კონტრაქტში ვანიჭებთ, შეგვიძლია გამოვიძახოთ _grantRole ფუნქცია და მივანიჭოთ კონკრეტულ მისამართს (address) სასურველი როლი.
    constructor() ERC1155("000") {
        // კონსტრუქტორში _grantRole ფუნქციის გამოყენებით ვანიჭებთ მისამართებს სასურველ როლებს.ვაძლევთ როლებს: DEFAULT_ADMIN_ROLE და MINTER_ROLE.
        // AccessControl.sol დეფოულთად არის კონკრეტულად DEFAULT_ADMIN_ROLE როლი, შესაბამისად მისი გამოცხადება ამ კონტრაქტში საჭირო არ არის.
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // ჩვენ შემთხვევაში კონსტრუქტორში რომ არ ვიწვალოთ სათითაოდ როლების მინიჭებაზე
        // შეგვიძლია გამოვიძახოთ AccessControl კონტრაქტიდან ფუნქცია revokeRole და მისი დახმარებით სასურველ მისამართებს მივანიჭოთ/გავაუქმოთ როლები, მაგალითად MENEGER_ROLE.
    }

    // function setURI(string memory newuri) public onlyRole(URI_SETTER_ROLE) - არ გვჭირდება რადგან ვაპირებთ mint-ის დროს URI-ს მითითებას, ამიტომ ამ ფუნქციას არ გამოვიყენებთ.

    // _tokenURIs - ეს არის mapping, რომელიც ასოცირდება uint256 ტიპის id-ს და string ტიპის URI-ს შორის.
    // ეს mapping გამოიყენება იმისთვის, რომ თითოეულ ტოკენს მივანიჭოთ უნიკალური URI, რომელიც შეიცავს ინფორმაციას ამ ტოკენის შესახებ.
    mapping(uint256 => string) private _tokenURIs;

    uint256 public currentTokenId = 0;

    // balanceOf - ეს არის ERC1155 სტანდარტის ნაწილი, რომელიც გამოიყენება იმისთვის, რომ გავიგოთ კონკრეტულ მისამართს (address) რამდენი ტოკენი აქვს კონკრეტული ID-ის (tokenId) მიხედვით.
    function hasToken(address _user, uint256 _tokenId) external view returns (bool) {
        return balanceOf(_user, _tokenId) > 0;
    }

    // სანამ როლებს გავიტანდით ცალკე კონტრაქტში, მოდიფიკატორი onlyRole(MINTER_ROLE) გამოიყურებოდა ასე.
    // ვინაიდან ახლა როლები ცალკე ბიბლიოთეკაშია გატანილი შესაბამისად დაემატება არ ბიბლიოთეკის სახელი და წერტილი, ანუ Roles.MINTER_ROLE.
    function mint(address account, uint256 amount, string memory _tokenURI)public onlyRole(Roles.MINTER_ROLE){
        uint256 newTokenId = currentTokenId;
        currentTokenId++;

        // _mint ფუნქცია არის ERC1155 სტანდარტის ნაწილი, რომელიც გამოიყენება ახალი ტოკენების შექმნისთვის (minting).
        // ეს ფუნქცია იღებს ოთხ პარამეტრს: მისამართი (account), რაოდენობა (amount), და დამატებითი მონაცემები (data).
        // ჩვენ შემთხვევაში, დამატებითი მონაცემები (data) არ გვჭირდება, ამიტომ ვაძლევთ მას ცარიელ სტრინგს ("").
        _mint(account, newTokenId, amount, "");

        _tokenURIs[newTokenId] = _tokenURI;
    }

    function updateUri(uint256 _tokenId, string memory _newTokenURI) external onlyRole(Roles.MENEGER_ROLE) {
        _tokenURIs[_tokenId] = _newTokenURI;
    }


    // function uri(uint256 id) public view override returns (string memory) - ეს ფუნქცია არის ERC1155 სტანდარტის ნაწილი, რომელიც გამოიყენება ტოკენის URI-ს მისაღებად.
    // ეს ფუნქცია იღებს ტოკენის ID-ს (id) და აბრუნებს მასთან ასოცირებულ URI-ს.
    // ჩვენ ამ ფუნქციას ვა_OVERRIDE_ებთ, რათა გამოიყენოს ჩვენი _tokenURIs mapping-ი, რომელიც ჩვენ შევქმენით ტოკენების URI-ს შესანახად.
    function uri(uint256 _tokenId) public view override returns (string memory) {
        return _tokenURIs[_tokenId];
    }

    //წავშალეთ batch mint ფუნქცია.
    //function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
