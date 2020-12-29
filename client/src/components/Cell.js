import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import { Dropdown } from 'semantic-ui-react'
import Building from "./Building"
import PopupContent from './PopupContent'

const TYPES = ["None", "Farm", "Mine"];

const Cell = ({ x, y, setPopup, reload }) => {
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

  useEffect(() => {
    const { contract, accounts } = state;
    const initialize = async () => {
      const building = await contract.methods.getBuildingByOwner(accounts[0], x, y).call({from: accounts[0]});
      const initType = building[1];
      console.log(initType);
      setType(initType);
    }
    if(contract !== null && accounts.length > 0) {
      initialize();
    }
  }, [state, reload]);

  return <>
    <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle} 
      onMouseEnter={() => onHover()} 
      onMouseLeave={() => unHover()} 
      onClick={() => setPopup(true, type, x, y)}>
      <Building type={type}/>
    </div>
  </>

    {/* <Popup
      content={
        
      }
      on='click'
      popper={{ id: 'popper-container', style: { zIndex: 2 } }}
      trigger={
        
      }
    /> */}
}

export default Cell;