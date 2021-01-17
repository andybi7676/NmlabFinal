pragma solidity >=0.4.21 <0.7.0;

import "./Account.sol";

contract Soldier is Account {
    mapping (address => uint) public numOfSoldier;

    mapping (address => uint) public levelOfSoldier;

    mapping (address => uint) public ownerStartCreateTime;
    mapping (address => uint) public ownerCreateSoldierTime;
    mapping (address => uint) public ownerStartLevelUpTime;
    uint public createSoldierTime = 10;
    uint public levelUpSoldierTime = 10;


    function _updatePower(address _owner) internal {
        power[_owner] = numOfSoldier[_owner] * levelOfSoldier[_owner];
    }

    function _createSoldier(address _owner, uint number) internal returns(bool) {
        uint foodCost = (25* levelOfSoldier[_owner] - 5) * number;
        uint ironCost = (25* levelOfSoldier[_owner] - 5) * number;
        uint coinCost = (25* levelOfSoldier[_owner] - 5) * number;

        return _cost(_owner, foodCost, uint(0), ironCost, uint(0), coinCost);
    }
    
    function _upgradeSoldier(address _owner) internal returns(bool){
        uint foodCost = 500* levelOfSoldier[_owner] - 125;
        uint ironCost = 500* levelOfSoldier[_owner] - 125;
        uint coinCost = 500* levelOfSoldier[_owner] - 125;

        return _cost(_owner, foodCost, uint(0), ironCost, uint(0), coinCost);
    }

    function getSoldierAmount(address _owner) public view returns(uint) {
        return numOfSoldier[_owner];
    }

}