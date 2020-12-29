import React from 'react';
import Map from './Map';
import { Grid, Menu } from 'semantic-ui-react';

const GameScene = () => {
  return (
    <Grid celled style={{margin: "0"}}>
    <Grid.Row>
      <Grid.Column width={3}>
        <Menu />
      </Grid.Column>
      <Grid.Column width={13}>
        <Map />
      </Grid.Column>
    </Grid.Row>
  </Grid>
  )
}

export default GameScene;
