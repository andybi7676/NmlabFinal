import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import { Modal, Button, Icon, Grid } from 'semantic-ui-react'
import Building from "./Building"
import ModalContent from './ModalContent'


const Cell = ({ x, y }) => {
  const state = useContext(ContractContext);
  const [ type, setType ] = useState("None");
  const [ index, setIndex ] = useState(0);
  const [ open, setOpen ] = useState(false);
  const [ reload, setReload ] = useState(false);
  const [ CellStyle, setCellStyle ] = useState({
    left: `${x}px`,
    top: `${y}px`,
    color: "#6CC",
    backgroundColor: "#FFF",
  });

  const onHover = () => {
    setCellStyle({
      left: `${x}px`,
      top: `${y}px`,
      "backgroundColor": "#999",
      color: "#fff",
    });
  }
  const unHover = () => {
    setCellStyle({
      left: `${x}px`,
      top: `${y}px`,
      color: "#6CC",
      backgroundColor: "#FFF",
    });
  }
  const makeReload = () => {
    setReload(!reload);
    setOpen(false);
  }

  useEffect(() => {
    const { contract, accounts } = state;
    const load = async () => {
      const building = await contract.methods.getBuildingByOwner(accounts[0], x, y).call({from: accounts[0]});
      const loadIndex = building[0];
      const loadType = building[1];
      console.log(loadIndex);
      console.log(loadType);
      setIndex(loadIndex);
      setType(loadType);
    }
    if(contract !== null && accounts.length > 0) {
      load();
    }
  }, [state, reload]);

  return <>
    <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle} 
      onMouseEnter={() => onHover()} 
      onMouseLeave={() => unHover()} 
      onClick={() => setOpen(true)}>
      <Building type={type}/>
    </div>

    <Modal
      dimmer='inverted'
      onClose={() => setOpen(false)}
      onOpen={() => setOpen(true)}
      open={open}
    >
      <ModalContent x={x} y={y} type={type} makeReload={makeReload} index={index} />
      <Modal.Actions>
        <Button onClick={() => setOpen(false)} color='red'>
          <Icon name='close' /> close
        </Button>
      </Modal.Actions>
    </Modal>
  </>

}

export default Cell;