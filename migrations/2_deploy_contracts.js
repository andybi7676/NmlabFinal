//var Account = artifacts.require("./Account.sol");
var Soldier = artifacts.require("./Soldier.sol");

module.exports = function(deployer) {
  //deployer.deploy(Account);
  deployer.deploy(Soldier);
};
