import React, { useEffect, useState, useContext } from "react";
import { ContractContext } from "../App";
import { Menu, Icon } from 'semantic-ui-react';
import "../styles/Navbar.css";


const Navbar = () => { 
  const state = useContext(ContractContext);
  const [ resources, setResources ] = useState({
    wood: 0,
    food: 0,
    iron: 0,
    stone: 0,
    coin: 0
  });

  useEffect(() => {
    const { contract, accounts } = state;
    const getResource = async () => {
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
  }, [state]);

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
          style={{ color: 'gray' }}
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
      </Menu>

    </div>


  )

}


export default Navbar;