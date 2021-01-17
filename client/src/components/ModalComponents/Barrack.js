import React, { useState, useEffect, useContext } from 'react';
import { Button, Modal, Grid, Icon, Segment, Header, Input, Progress } from 'semantic-ui-react';

const Barrack = ({ x, y, index, contract, account, makeReload }) => {
  const [ level, setLevel ] = useState(1);
  const [ produceAmount, setProduceAmount ] = useState(1);
  const [ soldierAmount, setSoldierAmount ] = useState(-1);
  const [ produceProgress, setProduceProgress ] = useState(0);
  const [ producing, setProducing ] = useState(false);
  const timeIncrementPercentage = 0;

  const getLevel = async() => {
    const building = await contract.methods.getBuildingById(index).call({from: account});
    const exist = building[0];
    const lv = building[2];
    if(exist) {
      setLevel(lv);
    }
  }

  const getSoldier = async() => {
    const getSM = await contract.methods.getSoldierAmount(account).call({from: account});
    setSoldierAmount(getSM);
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

  const producingProgress = (remainTime) => {
    const percentage = remainTime[0]/remainTime[1] *100;
    console.log(percentage);
    if(percentage > 100) {
      setProduceProgress(100);
      return;
    }
    setProduceProgress(percentage);
    setTimeout(() => {
      checkProduce()
    }, 1000);
  }

  const createSoldier = async () => {
    if(!contract || !account) return;
    if(produceAmount <= 0) return;
    await contract.methods.startCreateSoldier(produceAmount).send({from: account});
    setProducing(true);
  }

  const checkProduce = async () => {
    const remainTime = await contract.methods.getCreateSoldierTime().call({from: account});
    console.log(remainTime)
    const produceTime = parseInt(remainTime[1]);
    if(produceTime == 0) return;
    const startTime = parseInt(remainTime[0]);
    // console.log(remainTime.map((val)=>parseInt(val)));
    if(!producing) setProducing(true);
    producingProgress([startTime, produceTime]);
  }

  const handleInputChange = (e, { value }) => {
    e.preventDefault();
    setProduceAmount(value);
  }

  useEffect(() => {
    if(contract && account) {
      getLevel();
      getSoldier();
      checkProduce();
    }
  }, [contract, account, index, producing])

  return <>
    <Modal.Content image>
      <Grid columns='equal' divided padded>
        <Grid.Row stretched>
          <Grid.Column>
            <Header as='h4'>
              Level
            </Header>
            <Segment textAlign='center' compact color='grey' size='tiny'>
              {level}
            </Segment>
            {
              producing ?
              <>
              <Header as='h4'>
                Produce soldier progress
              </Header>
              <Progress percent={produceProgress} indicating />
              <div style={{textAlign: 'center'}}>
                <Button disabled={produceProgress !== 100} primary >
                  confirm soldier
                </Button>
              </div>
              </>
              :
              <>
              <Header as='h4'>
                Produce Soldier
              </Header>
              <Segment textAlign='center' compact color='grey' size='tiny'>
                <div>soldier amount: {produceAmount}</div>
                <Input
                  min={0}
                  max={10}
                  onChange={handleInputChange}
                  type='range'
                  value={produceAmount}
                />
              </Segment>
              <div style={{textAlign: 'center'}}>
                <Button primary onClick={() => createSoldier()} >produce</Button>
              </div>
              </>
            }
          </Grid.Column>
          <Grid.Column>
            <Header icon>
              Barrack
              <Icon name='shield alternate' style={{ color: 'black' }}/>
            </Header>
            <Segment padded color='black'>
              <p>Produce Soldier  </p>
              <p>Soldier amount: {soldierAmount}</p>
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

export default Barrack;