pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract ManorFactory is CastleFactory {
    
    mapping (address => uint) public ownerCoinProduceTime;
    uint produceCoinAbility = 1;

    function _createManor(uint _x, uint _y) internal {
        _createBuilding("Manor", _x, _y);
        _updateProduceCoin(msg.sender);
    }

    function _startBuildManor(address _owner, uint _x, uint _y) internal {
        manorID = _getBuildingByOwner(_owner, "Manor", _x, _y);
        require(buildings[manorID].add(1) <= castleLevel[_owner]);
        _startBuild(manorID);
    }

    function _updateProduceCoin(address _owner) internal {
        manors = _getSpecificBuildingByOwner(_owner, "Manor");
        if (manors.length > 1){
            while (now > ownerCoinProduceTime[_owner].add(10 seconds)) {
                for (uint i = 1; i < manors.length; i++) {
                    coinOwnerCount[_owner] = coinOwnerCount[_owner].add(buildings[manors[i]].level * produceCoinAbility );
                }
                ownerCoinProduceTime[_owner] = ownerCoinProduceTime[_owner].add(10 seconds);
            }
        }
        else {
            ownerCoinProduceTime[_owner] = now;
        }
    }
}