// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0

pragma solidity ^0.8.35;

library Roles {

    // function grantRole(bytes32 role, address account) public virtual onlyRole(getRoleAdmin(role))
    // ეს არის openzeppelin კონტრაქტის ნაწილი, რომელიც საშუალებას აძლევს როლების მმართველს (admin) მისცეს როლი სხვა ანგარიშს.
    // ეს ფუნქცია არის virtual, შესაბამისად თუ ის არ გვაკმაყოფილებს შეგვიძლია მოვახდინოთ მისი გადაფარვა (override) და შევცვალოთ მისი ლოგიკა,
    // მაგრამ ამ შემთხვევაში ჩვენ უბრალოდ გამოვიყენებთ მას ისე, როგორც არის და არ შევცვლით მის ფუნქციონირებას.

    // MINTER_ROLE - როლის სახელი, ("MINTER_ROLE") არის შეტყობინება ჩვენთვის, რომელიც გამოიყენება როლის იდენტიფიკატორად.
    // ასეთი როლების შექმნა შეგვიძლია რამდენიც გაგვიხარდება, მაგალითად MENEGER_ROLE და ა.შ. ეს როლები არის bytes32 ტიპის კონსტანტები, რომლებიც იწერება keccak256 ჰეშით.
    // შემდგომ შეგვიძლია ეს შექმნილი როლი მივანიჭოთ კონკრეტულ მისამართს და ეს მისამართი შეძლებს მისთვის მინიჭებულ როლს გამოყენებას.
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    bytes32 public constant MENEGER_ROLE = keccak256("MENEGER_ROLE");


}