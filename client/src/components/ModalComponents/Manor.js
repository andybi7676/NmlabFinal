import React, { useState, useEffect } from 'react';
import { Button, Modal, Grid, Icon, Segment, Header } from 'semantic-ui-react';

const PRODUCTION_RATE = 10;

const Manor = ({ x, y, index, contract, account, makeReload }) => {
  const [ level, setLevel ] = useState(1);
  const getLevel = async() => {
    const building = await contract.methods.getBuildingById(index).call({from: account});
    const exist = building[0];
    const lv = building[2];
    if(exist) {
      console.log(`level: ${lv}`);
      setLevel(lv);
    }
  }

  const upgradeBuilding = async () => {
    if(!contract || !account) return;
    await contract.methods.startBuild(account, x, y).send({from: account});
    const remainTime = await contract.methods.getRemainingTime(account).call({from: account});
    console.log(remainTime);
    setTimeout(async () => {
      console.log("update building");
      await contract.methods.updateBuild(account).send({from: account});
      getLevel();
      makeReload();
    }, 1000*(remainTime));
  }

  useEffect(() => {
    if(contract && account) {
      getLevel()
    }
  }, [contract, account, index])

  return <>
    <Modal.Content image>
      <Grid columns='equal' divided padded>
        <Grid.Row stretched>
          <Grid.Column>
              <Header as='h4'>
                Level
              </Header>
              <Segment textAlign='center' compact color='yellow' size='tiny'>
                {level}
              </Segment>
              <Header as='h4'>
                Production rate
              </Header>
              <Segment textAlign='center' compact color='yellow' size='tiny'>
                {level*PRODUCTION_RATE}
              </Segment>
          </Grid.Column>
          <Grid.Column>
            <Header icon>
              Manor
              <Icon name='bitcoin' style={{ color: 'gold' }}/>
            </Header>
            <Segment padded color='yellow'>
              <p>produce coin</p>
            </Segment>
            <div style={{textAlign: 'center'}}>
              <Button primary onClick={() => upgradeBuilding()} >upgrade</Button>
            </div>
          </Grid.Column>
        </Grid.Row>
      </Grid>
    </Modal.Content>
  </>
}

export default Manor;