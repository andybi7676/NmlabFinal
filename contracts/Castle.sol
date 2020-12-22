pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./BuildingFactory.sol";

contract CastleFactory is BuildingFactory {

    function _createCastle(uint _x, uint _y) internal {
        _createBuilding("Castle", _x, _y);
        castleLevel[msg.sender] = 1;
    }

    function _startBuildCastle(address _owner, uint _x, uint _y) internal {
        castleID = _getBuildingByOwner(_owner, "Castle", _x, _y);
        require(buildings[castleID].add(1) <= castleLevel[_owner]);
        _startBuild(castleID);
    }

    modifier lessThanCastle(address _owner, uint _buildingID) {
        require(buildings[_buildingsID].add(1) <= castleLevel[_owner]);
        _;
    }
}