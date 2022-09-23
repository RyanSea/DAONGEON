// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface ICharacter {

    struct Profile {
        string name;
        uint8 health;
        uint8 strength;
        uint8 magic;
        uint16 mana;
        address location_dungeon;
        string location_exact;
    }

    function profile(uint _id) external view returns (Profile memory);

    function tokenURI(uint _id) external view returns (string memory);

    function adjustProfile(uint _id, Profile memory _newProfile) external;

}