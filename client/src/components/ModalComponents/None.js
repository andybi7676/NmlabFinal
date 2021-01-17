import React, { useState } from 'react';
import { Button, Modal, Grid, Icon, Segment, Header, Menu, Pagination } from 'semantic-ui-react';
import { Page } from './index'

const None = ({ x, y, contract, contractB, account, makeReload }) => {
  const [ page, setPage ] = useState(0);

  const build = async (buildType) => {
    if(!contract || !account) {
      alert("please wait a minute and try again");
      return;
    }
    let newBuildingId;
    const { createSawmill, createFarm, createMine, createQuarry, createManor, createBarrack } = contract.methods;
    // const {  } = contractB.methods;
    switch (buildType) {
      case "Sawmill":
        newBuildingId = await createSawmill(x, y).send({from: account});
        break;
      case "Farm":
        newBuildingId = await createFarm(x, y).send({from: account});
        break;
      case "Mine":
        newBuildingId = await createMine(x, y).send({from: account});
        break;
      case "Quarry":
        newBuildingId = await createQuarry(x, y).send({from: account});
        break;
      case "Manor":
        newBuildingId = await createManor(x, y).send({from: account});
        break;
      case "Barrack":
        const haveBuilding = await contract.methods.getSpecificBuildingByOwner(account, "Barrack").call({from:account});
        if(haveBuilding.length > 0) {
          alert("Already have Barrack!");
          break;
        }
        newBuildingId = await createBarrack(x, y).send({from: account});
        break;
        default:
          console.alert("invalid buildingType");
          break;
    }
    console.log(newBuildingId);
    makeReload();
    const buildingLen = await contract.methods.getBuildingsLen().call({from: account});
    console.log(buildingLen);
  }

  return <>
    <Modal.Content image>
      <Grid columns='equal' divided inverted padded>
        <Grid.Row centered>
          <Menu pointing secondary>
            <Menu.Item
              name='basic'
              active={page === 0}
              onClick={()=>setPage(0)}
            />
            <Menu.Item
              name='advance'
              active={page === 1}
              onClick={()=>setPage(1)}
            />
          </Menu>
        </Grid.Row>
        <Grid.Row>
          <Page page={page} build={build}/>
        </Grid.Row>
      </Grid>
    </Modal.Content>
  </>
}

export default None;