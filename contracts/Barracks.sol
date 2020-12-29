pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";
import "./Soldier.sol";

contract BarrackFactory is CastleFactory, Soldier {
    
    function _createBarrack(uint _x, uint _y) internal {
        _createBuilding("Barrack", _x, _y);
    }

    function createSoldier(string _name, uint number) public {
        if (_name == "Cavalry") {
            createCavalry(number);
        }
        else if (_name == "Pikemen") {
            createPikemen(number);
        }
        else if (_name == "Infantry") {
            createInfantry(number);
        }
        else if (_name == "Archer") {
            createArcher(number);
        }
    }
}