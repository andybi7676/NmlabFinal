import React, { useState, useContext } from "react";
import { ContractContext } from "../App";
import "../styles/Cell.css";
import Building from "./Building"

const Cell = ({ x, y }) => {
  const state = useContext(ContractContext);
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
  return (
    <div className="Cell_1x1" tabIndex="1" id={`Cell-${x}*${y}`} style={CellStyle}>
      <Building type="none" onHover={onHover} unHover={unHover} />
    </div>
  )

}

export default Cell;