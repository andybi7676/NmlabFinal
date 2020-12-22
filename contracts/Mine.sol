pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract MineFactory is CastleFactory {
    
    mapping (address => uint) public oreOwnerCount;
    mapping (address => uint) public ownerOreProduceTime;
    uint produceOreAbility = 1;

    function _createMine(uint _x, uint _y) internal {
        _createBuilding("Mine", _x, _y);
        _updateProduceOre(msg.sender);
    }

    function _startBuildMine(address _owner, uint _x, uint _y) internal {
        mineID = _getBuildingByOwner(_owner, "Mine", _x, _y);
        require(buildings[mineID].add(1) <= castleLevel[_owner]);
        _startBuild(mineID);
    }

    function _updateProduceOre(address _owner) internal {
        mines = _getSpecificBuildingByOwner(_owner, "Mine");
        if (mines.length > 1){
            while (now > ownerOreProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < mines.length; i++) {
                    oreOwnerCount[_owner] = oreOwnerCount[_owner].add(buildings[mines[i]].level * produceOreAbility );
                }
                ownerOreProduceTime[_owner] = ownerOreProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerOreProduceTime[_owner] = now;
        }
    }
}