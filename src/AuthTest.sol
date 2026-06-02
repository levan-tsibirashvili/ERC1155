// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

import {IERC1155Auth} from "./IERC1155Auth.sol";

contract AuthTest {
    IERC1155Auth public auth;

    mapping(addresss => bool) participations;

    constructor (address _authAddress){
        auth = IRC1155Auth(_authAddress);
    }

    error UserDontHaveToken(uint256 _tokenID);

    // ფუნქცია participate - მონაწილეობის მიღება
    function participate () external {
        // ვახდენთ ავტორიზაციას ERC1155Auth.sol კონტრაქტის ბაზაზე დაყრდნობით
        // ანუ თუ msg.sender არ ფლობს ტოკენს N1-ს მაშინ require არ შესრულდება
        require(auth.hasToken(msg.sender, 1), UserDontHaveToken(1));

        participations[msg.sender] = true;
    }

}