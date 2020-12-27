import React from 'react';
import { Dropdown, Button } from 'semantic-ui-react';
import Farm from './Farm';

const Building = ({ type , level , onHover, unHover, changeType }) => {
  const create = () => {
    console.log("creating building");
  }

  if(type === "none") {
    return (
      //// will update by using Popup
      <Dropdown fluid pointing="left" icon={null} text='' onMouseEnter={onHover} onMouseLeave={unHover} >
        <Dropdown.Menu>
        <Dropdown.Item>
          <>
            <Dropdown clearable fluid pointing="left" text='Create Building'>
              <Dropdown.Menu>
                <Dropdown.Item>
                  Sawmill
                </Dropdown.Item>
                <Dropdown.Item>
                  Quarry
                </Dropdown.Item>
                <Dropdown.Item>
                  Mine
                </Dropdown.Item>
                <Dropdown.Item>
                  Manor
                </Dropdown.Item>
                <Dropdown.Item onClick={() => changeType("farm")}>
                  Farm
                </Dropdown.Item>
              </Dropdown.Menu>
            </Dropdown>
          </>
        </Dropdown.Item>
        <Dropdown.Divider />
        <Dropdown.Item>
          Info?
        </Dropdown.Item>
      </Dropdown.Menu>
      </Dropdown>
    )
  }
  if(type === "farm") {
    return <>
      <Farm changeType={changeType} />
    </>
  }
  else return<></>;
}

export default Building;