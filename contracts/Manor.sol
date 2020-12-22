pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract ManorFactory is CastleFactory {
    
    mapping (address => uint) public coinOwnerCount;
    uint produceCoinAbility = 1;

    function _createManor(uint _x, uint _y) internal {
        _createBuilding("Manor", _x, _y);
        _produceCoin(msg.sender, _x, _y);
    }

    function _startBuildManor(address _owner, uint _x, uint _y) internal {
        manorID = _getBuildingByOwner(_owner, "Manor", _x, _y);
        require(buildings[manorID].add(1) <= castleLevel[_owner]);
        _startBuild(manorID);
    }

    function _produceCoin(address _owner, uint _x, uint _y) internal {
        manorID = _getBuildingByOwner(_owner, "Manor", _x, _y);
        while (now > buildings[manorID].producetime.add(1 hours)) {
            buildings[manorID].producetime = buildings[manorID].produceTime.add(1 hours);
            coinOwnerCount[_owner] = coinOwnerCount[_owner].add(buildings[manorID].level * produceCoinAbility );
        } 
    }
}