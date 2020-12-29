import React from 'react';
import { Dropdown, Button, Icon } from 'semantic-ui-react';
import Farm from './Farm';

const Building = ({ type , level  }) => {
  const create = () => {
    console.log("creating building");
  }

  if(type === "None") {
    
  }
  if(type === "Farm") {
    return <Icon name='food'  size='huge' style={{transform: "rotate(-45deg)", color: "gainsboro"}} />
  }
  if(type === "Mine") {
    return <Icon name='lock' color="black" size='huge' style={{transform: "rotate(-45deg)"}} />
  }
  if(type === "Manor") {
    return <Icon name="bitcoin"  size='huge' style={{transform: "rotate(-45deg)", color: "gold" }} />
  }
  if(type === "Quarry") {
    return <Icon name="hand rock"  size='huge' style={{transform: "rotate(-45deg)", color: "gray" }} />
  }
  if(type === "Sawmill") {
    return <Icon name="tree"  size='huge' style={{transform: "rotate(-45deg)", color: "green" }} />
  }
  else return<></>;
}

export default Building;