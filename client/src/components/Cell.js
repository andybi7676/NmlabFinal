import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import { Popup } from 'semantic-ui-react'
import Building from "./Building"
import PopupContent from './PopupContent'


const Cell = ({ x, y }) => {
  const state = useContext(ContractContext);
  const [ type, setType ] = useState("None");
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

  const createBuilding = async (newType) => {
    const { contract, accounts } = state;
    
  }

  useEffect(() => {
    console.log(state);
    if(state.contract !== null) {
      state.contract.methods.buildings().call((err, msg)=>console.log(msg));
    }
  }, [state]);

  return <>
    <Popup
      content={
        <PopupContent type={type} />
      }
      on='click'
      popper={{ id: 'popper-container', style: { zIndex: 2 } }}
      trigger={
        <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle} onMouseEnter={() => onHover()} onMouseLeave={() => unHover()}>
          <Building type={type}/>
        </div>
      }
    />
  </>

}

export default Cell;