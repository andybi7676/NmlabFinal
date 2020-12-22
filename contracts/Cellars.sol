pragma solidity >=0.6.0 <0.8.0;

import "./SafeMath.sol";
import "./Castle.sol";

contract CellarFactory is CastleFactory {
    
    mapping (address => uint) OwnerSaveWood;
    mapping (address => uint) OwnerSaveOre;
    mapping (address => uint) OwnerSaveFood;
    mapping (address => uint) OwnerSaveCoin;
    mapping (address => uint) OwnerSaveRock;
    uint SaveResourceAbility = 100;
    
    function _createCellar(uint _x, uint _y) internal {
        _createBuilding("Cellar", _x, _y);
    }

    function _saveResource(string _owner) internal {
        cellars = _getSpecificBuildingByOwner(_owner, "Cellar");
        for (uint i = 0; i < cellars.length; i++) {
            uint saveAmount = buildings[cellars[i]].level * SaveResourceAbility;
            if (rockOwnerCount[_owner] <= saveAmount) {
                OwnerSaveRock[_owner] = OwnerSaveRock[_owner].add(rockOwnerCount[_owner]);
                rockOwnerCount[_owner] = 0;
            }
            else{
                rockOwnerCount[_owner] = rockOwnerCount[_owner].sub(saveAmount);
                OwnerSaveRock[_owner] = OwnerSaveRock[_owner].add(saveAmount);
            }
            if (oreOwnerCount[_owner] <= saveAmount) {
                OwnerSaveOre[_owner] = OwnerSaveOre[_owner].add(oreOwnerCount[_owner]);
                oreOwnerCount[_owner] = 0;
            }
            else{
                oreOwnerCount[_owner] = oreOwnerCount[_owner].sub(saveAmount);
                OwnerSaveOre[_owner] = OwnerSaveOre[_owner].add(saveAmount);
            }
            if (foodOwnerCount[_owner] <= saveAmount) {
                OwnerSaveFood[_owner] = OwnerSaveFood[_owner].add(foodOwnerCount[_owner]);
                foodOwnerCount[_owner] = 0;
            }
            else{
                foodOwnerCount[_owner] = foodOwnerCount[_owner].sub(saveAmount);
                OwnerSaveFood[_owner] = OwnerSaveFood[_owner].add(saveAmount);
            }
            if (coinOwnerCount[_owner] <= saveAmount) {
                OwnerSaveCoin[_owner] = OwnerSaveCoin[_owner].add(coinOwnerCount[_owner]);
                coinOwnerCount[_owner] = 0;
            }
            else{
                coinOwnerCount[_owner] = coinOwnerCount[_owner].sub(saveAmount);
                OwnerSaveCoin[_owner] = OwnerSaveCoin[_owner].add(saveAmount);
            }
            if (woodOwnerCount[_owner] <= saveAmount) {
                OwnerSaveWood[_owner] = OwnerSaveWood[_owner].add(woodOwnerCount[_owner]);
                woodOwnerCount[_owner] = 0;
            }
            else{
                woodOwnerCount[_owner] = woodOwnerCount[_owner].sub(saveAmount);
                OwnerSaveWood[_owner] = OwnerSaveWood[_owner].add(saveAmount);
            }
        }           
    }

    function _takeResource(string _owner) internal {
        rockOwnerCount[_owner] = rockOwnerCount[_owner].add(OwnerSaveRock[_owner]);
        OwnerSaveRock[_owner] = 0;
        oreOwnerCount[_owner] = oreOwnerCount[_owner].sub(OwnerSaveOre[_owner]);
        OwnerSaveOre[_owner] = 0;
        foodOwnerCount[_owner] = foodOwnerCount[_owner].sub(OwnerSaveFood[_owner]);
        OwnerSaveFood[_owner] = 0;
        coinOwnerCount[_owner] = coinOwnerCount[_owner].sub(OwnerSaveCoin[_owner]);
        OwnerSaveCoin[_owner] = 0;
        woodOwnerCount[_owner] = woodOwnerCount[_owner].sub(OwnerSaveWood[_owner]);
        OwnerSaveWood[_owner] = 0;        
    }
}