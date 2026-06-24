// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.6.0
pragma solidity ^0.8.35;

/// @title Roles
/// @notice Library for managing access control roles within the ecosystem.
/// @dev Defines constant bytes32 values for MINTER_ROLE and MENEGER_ROLE.
library Roles {
    /// @notice The keccak256 hash representing the MINTER_ROLE.
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    /// @notice The keccak256 hash representing the MENEGER_ROLE.
    bytes32 public constant MENEGER_ROLE = keccak256("MENEGER_ROLE");
}