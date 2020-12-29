import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import { Button, Menu, Header, Grid, Segment } from 'semantic-ui-react';
import "../styles/Map.css";

const PopupContent = ({ visible, type, x, y, setPopup, makeReload}) => {
  const state = useContext(ContractContext);

  const build = async (buildType) => {
    const { contract, accounts } = state;
    if(contract === null) {
      alert("please wait a minute and try again");
      return;
    }
    const newBuildingId = await contract.methods.createBuilding(buildType, x, y).send({from: accounts[0]});
    console.log(newBuildingId);
    makeReload();
    const buildingLen = await contract.methods.getBuildingsLen().call({from: accounts[0]});
    console.log(buildingLen);
  }

  const getbyid = async (id) => {
    const { contract, accounts } = state;
    console.log(await contract.methods.getBuildingById(id).call({from: accounts[0]}));

  }

  if (type === "None") {
    return <>
      <Menu vertical fluid>
        <Menu.Item name='buildFarm'>
          <Header as='h4'>Farm</Header>
          <p>generate food</p>
          <Button onClick={() => build("Farm")} >
            Build Farm!
          </Button>
        </Menu.Item>
        <Menu.Item name='buildMine'>
          <Header as='h4'>Mine</Header>
          <p>generate iron</p>
          <Button onClick={() => build("Mine")} >
            Build Mine!
          </Button>
        </Menu.Item>
        <Menu.Item name='buildManor'>
          <Header as='h4'>Manor</Header>
          <p>generate coin</p>
          <Button onClick={() => build("Manor")} >
            Build Manor!
          </Button>
        </Menu.Item>
        <Menu.Item name='buildQuarry'>
          <Header as='h4'>Quarry</Header>
          <p>generate stone</p>
          <Button onClick={() => build("Quarry")} >
            Build Quarry!
          </Button>
        </Menu.Item>
        <Menu.Item name='buildSawmill'>
          <Header as='h4'>Sawmill</Header>
          <p>generate wood</p>
          <Button onClick={() => build("Sawmill")} >
            Build Manor!
          </Button>
        </Menu.Item>
      </Menu>
      <Button className="close_button" disabled={!visible} circular icon='close' color='red' onClick={() => setPopup(false, "None", -1,-1 )} />
    </>;
  }

  return <>
    <Button className="close_button" disabled={!visible} circular icon='close' color='red' onClick={() => setPopup(false, "None", -1,-1 )} />
  </>
  
}

export default PopupContent;