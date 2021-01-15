pragma solidity >=0.4.21 <0.7.0;

import "./SafeMath.sol";
import "./Castle.sol";
import "./Soldier.sol";

contract BarrackFactory is CastleFactory, Soldier {
    
    using SafeMath for uint;
    using SafeMath for uint8;

    function createBarrack(uint _x, uint _y) public {
        _createBuilding(msg.sender, "Barrack", _x, _y);
    }

    // return 0 if failed (maybe already creating or not enough resource) otherwise return createtime
    function startCreateSoldier(string memory _name, uint number) public returns(uint) {
        address _owner = msg.sender;
        if(ownerStartCreateTime[_owner] != 0) return uint(0); // check if there is already creating soldiers
        bool enoughResource;
        uint8 levelOfSoldier;
        if (keccak256(bytes(_name)) == keccak256(bytes("Cavalry"))) {
            enoughResource = _createCavalry(_owner, number);
            ownerCreateSoldierName[_owner] = "Cavalry";
            levelOfSoldier = levelOfCavalry[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Pikemen"))) {
            enoughResource = _createPikemen(_owner, number);
            ownerCreateSoldierName[_owner] = "Pikemen";
            levelOfSoldier = levelOfPikemen[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Infantry"))) {
            enoughResource = _createInfantry(_owner, number);
            ownerCreateSoldierName[_owner] = "Infantry";
            levelOfSoldier = levelOfInfantry[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Archer"))) {
            enoughResource = _createArcher(_owner, number);
            ownerCreateSoldierName[_owner] = "Archer";
            levelOfSoldier = levelOfArcher[_owner];
        }
        if(enoughResource == false) return uint(0);
        ownerStartCreateTime[_owner] = now;
        ownerCreateSoldierTime[_owner] = createSoldierTime * levelOfSoldier * number;
        return ownerCreateSoldierTime[_owner];
    }

    // return 0 if success else return remaining time
    function updateCreateSoldier(address _owner) public returns(uint) {
        if (ownerStartCreateTime[_owner] != 0 && now >= ownerStartCreateTime[_owner].add(ownerCreateSoldierTime[_owner])) {
            uint num;
            if (keccak256(bytes(ownerCreateSoldierName[_owner])) == keccak256(bytes("Cavalry"))) {
                num = ownerCreateSoldierTime[_owner].div(levelOfCavalry[_owner].mul(createSoldierTime));
                numOfCavalry[_owner].add(num);
            }
            else if (keccak256(bytes(ownerCreateSoldierName[_owner])) == keccak256(bytes("Pikemen"))) {
                num = ownerCreateSoldierTime[_owner].div(levelOfPikemen[_owner].mul(createSoldierTime));
                numOfPikemen[_owner].add(num);
            }
            else if (keccak256(bytes(ownerCreateSoldierName[_owner])) == keccak256(bytes("Infantry"))) {
                num = ownerCreateSoldierTime[_owner].div(levelOfInfantry[_owner].mul(createSoldierTime));
                numOfInfantry[_owner].add(num);
            }
            else if (keccak256(bytes(ownerCreateSoldierName[_owner])) == keccak256(bytes("Archer"))) {
                num = ownerCreateSoldierTime[_owner].div(levelOfArcher[_owner].mul(createSoldierTime));
                numOfArcher[_owner].add(num);
            }
            ownerStartCreateTime[_owner] = 0;
            ownerCreateSoldierTime[_owner] = 0;
            _updatePower(_owner);
            return 0;
        }
        else {
            uint remainingTime = ownerCreateSoldierTime[_owner].sub(now);
            return remainingTime;
        }
    }

    // return 0 if failed (maybe already creating or not enough resource) otherwise return leveluptime
    function startLevelUpSoldier(string memory _name) public returns(uint) {
        address _owner = msg.sender;
        if (ownerStartLevelUpTime[_owner] != 0) return uint(0);// check if there is already leveling up soldiers
        bool enoughResource;
        uint8 levelOfSoldier;
        uint numOfSoldier;
        if (keccak256(bytes(_name)) == keccak256(bytes("Cavalry"))) {
            enoughResource = _upgradeCavalry(_owner);
            ownerLevelUpSoldierName[_owner] = "Cavalry";
            levelOfSoldier = levelOfCavalry[_owner];
            numOfSoldier = numOfCavalry[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Pikemen"))) {
            enoughResource = _upgradePikemen(_owner);
            ownerLevelUpSoldierName[_owner] = "Pikemen";
            levelOfSoldier = levelOfPikemen[_owner];
            numOfSoldier = numOfPikemen[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Infantry"))) {
            enoughResource = _upgradeInfantry(_owner);
            ownerLevelUpSoldierName[_owner] = "Infantry";
            levelOfSoldier = levelOfInfantry[_owner];
            numOfSoldier = numOfInfantry[_owner];
        }
        else if (keccak256(bytes(_name)) == keccak256(bytes("Archer"))) {
            enoughResource = _upgradeArcher(_owner);
            ownerLevelUpSoldierName[_owner] = "Archer";
            levelOfSoldier = levelOfArcher[_owner];
            numOfSoldier = numOfArcher[_owner];
        }
        if(enoughResource == false) return uint(0);
        ownerStartLevelUpTime[_owner] = now;
        return levelUpSoldierTime * numOfSoldier * uint(levelOfSoldier);
    }

    function updateLevelUpSoldier(address _owner) public returns(uint) {
        uint8 levelOfSoldier;
        uint numOfSoldier;
        if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Cavalry"))) {
            levelOfSoldier = levelOfCavalry[_owner];
            numOfSoldier = numOfCavalry[_owner];
        }
        else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Pikemen"))) {
            levelOfSoldier = levelOfPikemen[_owner];
            numOfSoldier = numOfPikemen[_owner];
        }
        else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Infantry"))) {
            levelOfSoldier = levelOfInfantry[_owner];
            numOfSoldier = numOfInfantry[_owner];
        }
        else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Archer"))) {
            levelOfSoldier = levelOfArcher[_owner];
            numOfSoldier = numOfArcher[_owner];
        }
        if (ownerStartLevelUpTime[_owner] != 0 && now >= ownerStartLevelUpTime[_owner].add(levelUpSoldierTime * numOfSoldier * uint(levelOfSoldier))) {
            if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Cavalry"))) {
                levelOfCavalry[_owner]++;
            }
            else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Pikemen"))) {
                levelOfPikemen[_owner]++;
            }
            else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Infantry"))) {
                levelOfInfantry[_owner]++;
            }
            else if (keccak256(bytes(ownerLevelUpSoldierName[_owner])) == keccak256(bytes("Archer"))) {
                levelOfArcher[_owner]++;
            }
            ownerStartLevelUpTime[_owner] = 0;
            _updatePower(_owner);
            return 0;
        }
        else {
            uint remainingTime = levelUpSoldierTime * numOfSoldier * uint(levelOfSoldier) - now;
            return remainingTime;
        }
    }
}