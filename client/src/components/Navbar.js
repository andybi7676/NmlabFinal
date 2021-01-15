import React, { useEffect, useState, useContext } from "react";
import { ContractContext } from "../App";
import { Menu, Icon, Button } from 'semantic-ui-react';
import "../styles/Navbar.css";


const Navbar = () => { 
  const state = useContext(ContractContext);
  const [ resources, setResources ] = useState({
    wood: "--",
    food: "--",
    iron: "--",
    stone: "--",
    coin: "--"
  });
  const [ updateResources, setUpdateResources ] = useState(0);

  useEffect(() => {
    if(updateResources === 0) return;
    const { contract, accounts } = state;
    const getResource = async () => {
      const result = await contract.methods.updateProduce(accounts[0]).send({from: accounts[0]});
      console.log(result);
      const wood = await contract.methods.getWoodAmount().call({from: accounts[0]});
      const food = await contract.methods.getFoodAmount().call({from: accounts[0]});
      const iron = await contract.methods.getIronAmount().call({from: accounts[0]});
      const stone = await contract.methods.getStoneAmount().call({from: accounts[0]});
      const coin = await contract.methods.getCoinAmount().call({from: accounts[0]});
      setResources({ wood, food, iron, stone, coin });
    }
    if(contract !== null && accounts.length > 0) {
      getResource()
    }
  }, [updateResources, state]);

  return (
    <div className="navbar">
      <Menu secondary className="welcome-menu">
        <Menu.Item
          name='wood'
          style={{ color: 'green' }}
        >
        <Icon name="tree" />
          {resources.wood}
        </Menu.Item>
        <Menu.Item
          name='food'
          style={{ color: 'gainsboro' }}
        >
        <Icon name="food" />
          {resources.food}
        </Menu.Item>
        <Menu.Item
          name='iron'
          style={{ color: 'black' }}
        >
        <Icon name="lock" />
          {resources.iron}
        </Menu.Item>
        <Menu.Item
          name='stone'
          style={{ color: 'gray' }}
        >
        <Icon name="hand rock" />
          {resources.stone}
        </Menu.Item>
        <Menu.Item
          name='coin'
          style={{ color: "gold" }}
        >
        <Icon name="bitcoin" />
          {resources.coin}
        </Menu.Item>
        <Button onClick={() => setUpdateResources((updateResources+1)%1000)} inverted color='teal'>
          update resources
        </Button>
      </Menu>

    </div>


  )

}


export default Navbar;