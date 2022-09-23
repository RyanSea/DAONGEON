// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/utils/Strings.sol";

import "./interfaces/ICharacter.sol";

contract Dungeon {

    /*///////////////////////////////////////////////////////////////
                            INITIALIZATION
    //////////////////////////////////////////////////////////////*/

    ICharacter immutable character;

    struct Environment {
        string location; // styled like a layered chessboard 
        NPC[] npcs;
        uint[] characters; // ids[]
        Item[] items;
    }

    mapping (string => Environment) private layout;

    constructor(address character_address, Environment[] memory environments) {
        character = ICharacter(character_address);

        uint length = environments.length;

        for (uint i; i < length; ++i) {
            layout[environments[i].location] = environments[i];
        }
    }

    enum Movement {   
        move_north,  
        move_south,
        move_east,   
        move_west,
        move_up,
        move_down,
        exit
    }

    enum ItemType {
        health,
        magic,
        strength
    }

    enum AttackType {
        strength,
        magic
    }

    struct NPC {
        bool friendly;
        uint8 health;
        uint8 strength;
        uint8 magic;
        uint8 dexterity;
        uint8 mana;
    }

    struct Item {
        string name;
        ItemType itemType;
        uint8 stat;
        uint duration; // >= 5000 for permenant i.e. a sword
    }

    /*///////////////////////////////////////////////////////////////
                                  GAME
    //////////////////////////////////////////////////////////////*/

    /// @notice move action
    /// @param _player nft id
    function move(uint _player, Movement /*_move */) public {
        ICharacter.Profile memory player = character.profile(_player);

        string memory location = player.location_exact;

        uint length = layout[location].characters.length;

        // remove player id from previous Environment
        for (uint i; i < length; ++i) {
            if(layout[location].characters[i] == _player) {
                layout[location].characters[i] = layout[location].characters[length - 1];

                layout[location].characters.pop();

                break;
            }
        }  

        // utilize oz's Strings.sol to parse location..
        // psuedocode to follow:
        location = "new location";

        // change player's location_exact
        player.location_exact = location;
        character.adjustProfile(_player, player);

        // add player id to new Environment
        layout[location].characters.push(_player);
    }

    
}
