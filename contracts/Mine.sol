pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract MineFactory is CastleFactory {
    
    using SafeMath for uint;
    
    mapping (address => uint) public ownerIronProduceTime;
    uint produceIronAbility = 1;

    function _createMine(uint _x, uint _y) internal {
        createBuilding("Mine", _x, _y);
        _updateProduceIron(msg.sender);
    }


    function _updateProduceIron(address _owner) internal {
        uint[] memory mines = getSpecificBuildingByOwner(_owner, "Mine");
        if (mines.length > 0){
            while (now > ownerIronProduceTime[_owner].add(10 seconds)) {
                for (uint i = 0; i < mines.length; i++) {
                    ironOwnerCount[_owner] = ironOwnerCount[_owner].add(buildings[mines[i]].level * produceIronAbility );
                }
                ownerIronProduceTime[_owner] = ownerIronProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerIronProduceTime[_owner] = now;
        }
    }
}