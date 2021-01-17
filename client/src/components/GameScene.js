import React, { useEffect, useState, useContext} from 'react';
import { Map, Battle, Navbar } from './index';
import { ContractContext } from '../App'
import { Grid, Menu, Button, Segment } from 'semantic-ui-react';


const GameScene = () => {
  const [ newUser, setNewUser ] = useState(true);
  const state = useContext(ContractContext);

  useEffect(() => {
    const { contract, accounts } = state;
    const load = async () => {
      const checkUser = await contract.methods.checkUserAddress().call({from:accounts[0]});
      setNewUser(!checkUser)
    }
    if(contract !== null && accounts.length > 0) {
      load();
    }
  }, [state])
  
  const initializeKingdom = async () => {
    const { contract, accounts } = state;
    if(contract == null || accounts.length < 1) {
      alert("contract error!");
      return;
    }
    const create = await contract.methods.createCastle(650, 300).send({from: accounts[0]});
    console.log(create);
    setNewUser(false);
  }
  

  return newUser ?
    <Button primary size="massive" onClick={() => initializeKingdom()}>
      Initialize your kingdom!
    </Button>
    :
    <>
      <Navbar />
      <Grid celled style={{margin: "0"}}>
        <Grid.Row>
          <Grid.Column width={3}>
            <Battle />
          </Grid.Column>
          <Grid.Column width={13}>
            <Map />
          </Grid.Column>
        </Grid.Row>
      </Grid>
    </>
}

export default GameScene;
