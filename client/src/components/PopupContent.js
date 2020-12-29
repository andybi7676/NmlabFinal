import React, { useState } from "react";
import { Dropdown, Button, Menu, Header, Popup } from 'semantic-ui-react';

const PopupContent = ({ type, onBuild }) => {

  let content;

  switch (type) {
    case "None":
      content = <>
        <Popup
          content={
            <Menu vertical>
              <Menu.Item
                name='buildFarm'
              >
                <Header as='h4'>Farm</Header>
                <p>generate food</p>
              </Menu.Item>
              <Menu.Item
                name='buildMine'
              >
                <Header as='h4'>Mine</Header>
                <p>generate iron</p>
              </Menu.Item>
            </Menu>
          }
          on='click'
          popper={{ id: 'popper-container', style: { zIndex: 2 } }}
          trigger={
            <Button content="BUILD" icon="building" />
          }
        />
      </>;
      break;
    case "Farm":
      content = <>
        This is content for type farm.
      </>;
    default:
      content = <></>
      break;
  }

  return content;
}

export default PopupContent;