import React from 'react';
import { Button, Modal, Grid, Icon, Segment, Header, Menu, Pagination } from 'semantic-ui-react';

const Page = ({ page, build }) => {
  if(page === 0) {
    return <>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Sawmill
            <Icon name='tree' style={{ color: 'green' }} />
          </Header>
          <Button primary onClick={() => build("Sawmill")}>Build</Button>
        </Segment>
      </Grid.Column>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Farm
            <Icon name='food' style={{ color: 'gainsboro' }} />
          </Header>
          <Button primary onClick={() => build("Farm")}>Build</Button>
        </Segment>
      </Grid.Column>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Mine
            <Icon name='lock' style={{ color: 'black' }} />
          </Header>
          <Button primary onClick={() => build("Mine")}>Build</Button>
        </Segment>
      </Grid.Column>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Quarry
            <Icon name='hand rock' style={{ color: 'gray' }} />
          </Header>
          <Button primary onClick={() => build("Quarry")}>Build</Button>
        </Segment>
      </Grid.Column>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Manor
            <Icon name='bitcoin' style={{ color: 'gold' }} />
          </Header>
          <Button primary onClick={() => build("Manor")}>Build</Button>
        </Segment>
      </Grid.Column>
    </>
  }
  if(page === 1) {
    return <>
      <Grid.Column>
        <Segment placeholder>
          <Header icon>
            Barrack
            <Icon name='shield alternate' style={{ color: 'black' }} />
          </Header>
          <Button primary onClick={() => build("Barrack")}>Build</Button>
        </Segment>
      </Grid.Column>
    </>
  }
}

export default Page;