// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Dungeon.sol";

contract DungeonFactory {

    /// @notice address of Character contract
    address public character;

    /// @notice address => if it's a dungeon
    mapping(address => bool) public dungeonList;

    constructor(address character_address) {
        character = character_address;
    }
    
    function create(Dungeon.Environment[] memory layout) public {
        Dungeon _dungeon = new Dungeon(character, layout);

        dungeonList[address(_dungeon)] = true;
    }

}