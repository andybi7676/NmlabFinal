import React from 'react';

import { Dropdown, Button, Icon, Image } from 'semantic-ui-react';
import farm from '../images/farm.png';

const Building = ({ type , level  }) => {

  const height = 100;
  if(type === "None") {
    
  }
  if(type === "Farm") {
    return <Image src={farm} style={{transform: "rotate(-45deg)", zIndex: "3", height: `${188}%`, width:`${263}%` ,maxWidth: "500%", position: "relative", top: "1vh", left:"-8.5vh"}}/>
    // return <Icon name='food'  size='huge' style={{transform: "rotate(-45deg)", color: "gainsboro"}} />
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