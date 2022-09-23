// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface ICharacter {

    struct Profile {
        string name;
        uint health;
        uint strength;
        uint mana;
        address location_dungeon;
        string location_exact;
    }

    function profile(uint _id) external view returns (Profile memory);

    function tokenURI(uint _id) external view returns (string memory);

    function adjustProfile(uint _id, Profile memory _newProfile) external;

}