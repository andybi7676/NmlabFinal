pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";

contract Account {
    using SafeMath for uint;

    mapping (address => uint) public stoneOwnerCount;
    mapping (address => uint) public ironOwnerCount;
    mapping (address => uint) public foodOwnerCount;
    mapping (address => uint) public coinOwnerCount;
    mapping (address => uint) public woodOwnerCount;
    mapping (address => uint) public power;

    mapping (uint => address) public castleToOwner;
    mapping (address => uint) public onwerCastleCount;

    uint IdDigits = 16;
    uint IdModulus = 10 ** IdDigits;

    function _createCastle(string _name, uint _id) internal {
        castleToOwner[_id] = msg.sender;
        ownerCastleCount[msg.sender]++;
        NewCastle(_name, _id);
    }

    function _generateRandomId(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % IdModulus;
    }

    // for web to create castle
    function createRandomCastle(string _name) public {
        require(ownerCastleCount[msg.sender] == 0);
        uint randId = _generateRandomId(_name);
        randId = randId - randId % 100;
        _createCastle(_name, randId);
    }

    function _cost(uint food, uint wood, uint iron, uint stone, uint coin) internal returns (bool){
        if(foodOwnerCount[msg.sender]>=food && woodOwnerCount[msg.sender]>=wood && ironOwnerCount[msg.sender]>=iron && stoneOwnerCount[msg.sender]>=stone && coinOwnerCount[msg.sender]>=coin){
            foodOwnerCount[msg.sender].sub(food);
            woodOwnerCount[msg.sender].sub(wood);
            ironOwnerCount[msg.sender].sub(iron);
            stoneOwnerCount[msg.sender].sub(stone);
            coinOwnerCount[msg.sender].sub(coin);
            return true;
        }
        return false;
    }

    function getFoodAmount() public view returns(uint) {
        return foodOwnerCount[msg.sender];
    }

    function getIronAmount() public view returns(uint) {
        return ironOwnerCount[msg.sender];
    }

    function getStoneAmount() public view returns(uint) {
        return stoneOwnerCount[msg.sender];
    }

    function getCoinAmount() public view returns(uint) {
        return coinOwnerCount[msg.sender];
    }

    function getWoodAmount() public view returns(uint) {
        return woodOwnerCount[msg.sender];
    }
}