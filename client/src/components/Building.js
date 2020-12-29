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
    return <Icon name='tree' color="green" />
  }
  else return<></>;
}

export default Building;