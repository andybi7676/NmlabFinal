pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract MineFactory is CastleFactory {
    
    mapping (address => uint) public ownerIronProduceTime;
    uint produceIronAbility = 1;

    function _createMine(uint _x, uint _y) internal {
        _createBuilding("Mine", _x, _y);
        _updateProduceIron(msg.sender);
    }

    function _startBuildMine(address _owner, uint _x, uint _y) internal {
        mineID = _getBuildingByOwner(_owner, "Mine", _x, _y);
        require(buildings[mineID].add(1) <= castleLevel[_owner]);
        _startBuild(mineID);
    }

    function _updateProduceIron(address _owner) internal {
        mines = _getSpecificBuildingByOwner(_owner, "Mine");
        if (mines.length > 1){
            while (now > ownerIronProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < mines.length; i++) {
                    ironOwnerCount[_owner] = ironOwnerCount[_owner].add(buildings[mines[i]].level * produceIronAbility );
                }
                ownerIronroduceTime[_owner] = ownerIronProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerOreProduceTime[_owner] = now;
        }
    }
}