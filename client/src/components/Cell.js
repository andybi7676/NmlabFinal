import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import { Modal, Button, Icon, Grid } from 'semantic-ui-react'
import Building from "./Building"
import ModalContent from './ModalContent'


const Cell = ({ idx , x, y, initialized,  cellState, updateCellState }) => {
  const [ open, setOpen ] = useState(false);
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

  return <>
    <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle} 
      onMouseEnter={() => onHover()} 
      onMouseLeave={() => unHover()} 
      onClick={() => setOpen(true)}>
      <Building type={initialized? cellState.type : "undefined"} />
    </div>

    <Modal
      dimmer='inverted'
      onClose={() => setOpen(false)}
      onOpen={() => setOpen(true)}
      open={open}
    >
      <ModalContent idx={idx} x={x} y={y} cellState={initialized? cellState : null} type={initialized? cellState.type : "undefined"} index={initialized? cellState.index : "undefined"} updateCellState={updateCellState} />
      <Modal.Actions>
        <Button onClick={() => setOpen(false)} color='red'>
          <Icon name='close' /> close
        </Button>
      </Modal.Actions>
    </Modal>
  </>

}

export default Cell;