import React, { useState } from "react";
import { Button, Menu, Header, Grid, Segment } from 'semantic-ui-react';
import "../styles/Map.css";

const PopupContent = ({ visible, type, x, y, setPopup }) => {
  if (type === "None") {
    return <>
      <Menu vertical fluid>
        <Menu.Item name='buildFarm'>
          <Header as='h4'>Farm</Header>
          <p>generate food</p>
          <Button>
            Build Farm!
          </Button>
        </Menu.Item>
        <Menu.Item name='buildMine'>
          <Header as='h4'>Mine</Header>
          <p>generate iron</p>
          <Button>
            Build Mine!
          </Button>
        </Menu.Item>
      </Menu>
      <Button className="close_button" disabled={!visible} circular icon='close' color='red' onClick={() => setPopup(false, "None", -1,-1 )} />
    </>;
  }

  
}

export default PopupContent;