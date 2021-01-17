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
  const [ updateTimes, setUpdateTimes ] = useState(0);

  useEffect(() => {
    const { contract, accounts } = state;
    if(!contract || accounts.length < 1) return;
    const updateResource = async () => {
      const result = await contract.methods.updateProduce(accounts[0]).send({from: accounts[0]});
      console.log(result);
      const wood = await contract.methods.getWoodAmount().call({from: accounts[0]});
      const food = await contract.methods.getFoodAmount().call({from: accounts[0]});
      const iron = await contract.methods.getIronAmount().call({from: accounts[0]});
      const stone = await contract.methods.getStoneAmount().call({from: accounts[0]});
      const coin = await contract.methods.getCoinAmount().call({from: accounts[0]});
      setResources({ wood, food, iron, stone, coin });
    }
    const getResource = async () => {
      const wood = await contract.methods.getWoodAmount().call({from: accounts[0]});
      const food = await contract.methods.getFoodAmount().call({from: accounts[0]});
      const iron = await contract.methods.getIronAmount().call({from: accounts[0]});
      const stone = await contract.methods.getStoneAmount().call({from: accounts[0]});
      const coin = await contract.methods.getCoinAmount().call({from: accounts[0]});
      setResources({ wood, food, iron, stone, coin });
    }
    if(updateTimes === 0) {
      getResource();
      return;
    };
    updateResource();
  }, [updateTimes, state]);

  return (
    <div className="navbar">
      <Menu secondary className="welcome-menu" >
        <Menu.Menu position='right'>
          <Button.Group floated='right'>
            <Button animated='fade' circular onClick={() => setUpdateTimes(updateTimes+1)} inverted color='teal'>
              <Button.Content hidden>Refresh</Button.Content>
              <Button.Content visible  >
                <Icon name='sync' />
              </Button.Content>
            </Button>
            {/* <Button circular icon='sync' onClick={() => setUpdateTimes(updateTimes+1)} inverted color='blue'/> */}
            <Button active color='blue' inverted size='mini' icon="tree" style={{ color: 'green' }} content={resources.wood}/>
            <Button active color='blue' inverted size='mini' icon="food" style={{ color: 'gainsboro' }} content={resources.food}/>
            <Button active color='blue' inverted size='mini' icon="lock" style={{ color: 'black' }} content={resources.iron}/>
            <Button active color='blue' inverted size='mini' icon="bitcoin" style={{ color: 'gold' }} content={resources.coin}/>
            <Button active color='blue' inverted size='mini' icon="hand rock" style={{ color: 'gray' }} content={resources.stone}/>
          </Button.Group>
          {/* <Menu.Item
            name='wood'
            style={{ color: 'green' }}
          >
            <Icon size='mini' name="tree"  />
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
          </Menu.Item> */}
        </Menu.Menu>
      </Menu>
    </div>


  )

}


export default Navbar;