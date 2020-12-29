pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";
import "./Soldier.sol";

contract BarrackFactory is CastleFactory, Soldier {
    
    // function _createBarrack(uint _x, uint _y) internal {
    //     createBuilding("Barrack", _x, _y);
    // }

    // function createSoldier(string memory _name, uint number) public {
    //     if (keccak256(bytes(_name)) == keccak256(bytes("Cavalry"))) {
    //         createCavalry(number);
    //     }
    //     else if (keccak256(bytes(_name)) == keccak256(bytes("Pikemen"))) {
    //         createPikemen(number);
    //     }
    //     else if (keccak256(bytes(_name)) == keccak256(bytes("Infantry"))) {
    //         createInfantry(number);
    //     }
    //     else if (keccak256(bytes(_name)) == keccak256(bytes("Archer"))) {
    //         createArcher(number);
    //     }
    // }
}