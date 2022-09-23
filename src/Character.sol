// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @dev commented out function tokenURI
import "solmate/tokens/ERC721.sol";

/// @title DAOngeon Character
contract Character is ERC721 {

    /*///////////////////////////////////////////////////////////////
                            INITIALIZATION
    //////////////////////////////////////////////////////////////*/

    constructor() ERC721("Labrynth DAOngeon Character","LABRYNTH_FIGHTER"){}

    struct Profile {
        string name;
        uint8 health;
        uint8 strength;
        uint8 magic;
        uint16 mana;
        address location_dungeon;
        string location_exact;
    }

    /// @notice character id
    uint public id;

    /// @notice nft id => uri
    mapping(uint => string) public tokenURI;

    /// @notice nft id => Profile
    mapping (uint => Profile) public profile;

    /*///////////////////////////////////////////////////////////////
                                PLAYER
    //////////////////////////////////////////////////////////////*/

    event CharacterCreated(address owner, uint _id);

    event CharacterDestroyed(address previousOwner, uint _id);

    function create(
        address to, 
        string memory uri,
        Profile memory _profile
    ) public {
        ++id;

        _mint(to, id);

        tokenURI[id] = uri;

        profile[id] = _profile;

        emit CharacterCreated(to, id);
    }

    /// @notice destroys character
    function destroy(uint _id) public {
        address _owner = ownerOf(_id);
        
        require(_owner == msg.sender, "NOT_OWNED");

        _burn(_id);

        // clearn tokenURI
        tokenURI[_id] = "";

        // clear profile
        Profile memory _profile;
        profile[_id] = _profile;

        emit CharacterDestroyed(_owner, _id);
    }

    function adjustProfile(uint _id, Profile memory _newProfile) public {
        profile[_id] = _newProfile;
    }

    /*///////////////////////////////////////////////////////////////
                                SOULBOUND
    //////////////////////////////////////////////////////////////*/

    function transferFrom(
        address,
        address,
        uint256
    ) public virtual override { 
        revert("SOULBOUND");
    }

    function safeTransferFrom(
        address,
        address,
        uint256
    ) public virtual override { 
        revert("SOULBOUND");
    }

    function safeTransferFrom(
        address,
        address,
        uint256,
        bytes calldata 
    ) public virtual override { 
        revert("SOULBOUND");
    }

}
