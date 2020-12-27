import React, { useState, useContext } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import Building from "./Building"

const Cell = ({ x, y }) => {
  const state = useContext(ContractContext);
  const [ type, setType ] = useState("none");
  const [ CellStyle, setCellStyle ] = useState({
    border: "1.5px solid #999",
    color: "#6CC",
    backgroundColor: "#FFF",
  });
  const onHover = () => {
    setCellStyle({
      "backgroundColor": "#999",
      border: "2px solid #999",
      color: "#fff",
    });
  }
  const unHover = () => {
    setCellStyle({
      border: "1.5px solid #999",
      color: "#6CC",
      backgroundColor: "#FFF",
    });
  }

  const changeType = (newType) => {
    unHover();
    setType(newType);
  }
  return (
    <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle}>
      <Building type={type} onHover={onHover} unHover={unHover} changeType={changeType}/>
    </div>
  )

}

export default Cell;