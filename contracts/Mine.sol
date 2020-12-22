pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract MineFactory is CastleFactory {
    
    mapping (address => uint) public oreOwnerCount;
    uint produceOreAbility = 1;

    function _createMine(uint _x, uint _y) internal {
        _createBuilding("Mine", _x, _y);
        _produceOre(msg.sender, _x, _y);
    }

    function _startBuildMine(address _owner, uint _x, uint _y) internal {
        mineID = _getBuildingByOwner(_owner, "Mine", _x, _y);
        require(buildings[mineID].add(1) <= castleLevel[_owner]);
        _startBuild(mineID);
    }

    function _produceOre(address _owner, uint _x, uint _y) internal {
        mineID = _getBuildingByOwner(_owner, "Mine", _x, _y);
        while (now > buildings[mineID].producetime.add(1 hours)) {
            buildings[mineID].producetime = buildings[mineID].produceTime.add(1 hours);
            oreOwnerCount[_owner] = oreOwnerCount[_owner].add(buildings[mineID].level * produceOreAbility );
        } 
    }
}