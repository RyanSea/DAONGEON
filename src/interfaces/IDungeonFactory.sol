// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IDungeonFactory {
    function dungeonList(address _dungeon) external view returns (bool);
}