import React from 'react';
import { Button, Icon, Popup } from 'semantic-ui-react';


const Farm = ({changeType}) => {


  return (
    <Popup on='click' trigger={<Button icon='tree' color="green" />}>
      <Button onClick={() => changeType("none")} >remove</Button>
    </Popup>
  )

}

export default Farm;