import React, { useState } from "react";
import { useMeasure } from 'react-use'
import Cell from './Cell';
import "../styles/Map.css";
import gameBackground from '../images/gameBackground2.jpg';
import Draggable from 'react-draggable';


const imgWidth = 1311;
const imgHeight = 646;
const cellAry = [[10, 10], [130, 50], [380, 270], [280, 100], [40, 300], [650, 300], [800, 600], [1000, 300], [900, 100], [700, 400]];
const Map = () => {
  const [ref, { width, height }] = useMeasure();
  const [ reload, setReload ] = useState(false);
  const [ cellStateList, setCellStateList ] = useState(cellAry.map(_ => ({type: "unload", open: false, index: 0, others: null }) ))
  // console.log(width, height);

  const updateCellState = (idx, newState) => {
    setCellStateList([ ...cellStateList.slice(0, idx), newState, ...cellStateList.slice(idx+1)]);
  }

  const boundStyle = {left: -(imgWidth - width)/2, right: (imgWidth - width)/2, top: -(imgHeight - height), bottom: 0 };
  
  return (
    <div className="flex_div container" ref={ref} >
      {/* <div className="popup_div" style={{visibility: popupState.visible?"visible":"hidden"}}>
        <PopupContent popupState={popupState} setPopup={setPopup} makeReload={makeReload} />
      </div> */}
      <Draggable bounds={boundStyle}>
        <div className="inline_div">
          <img src={gameBackground} alt="Workplace" className="background_img"/>
          {
            cellAry.map((xy_list, idx) => {
              const [x, y] = xy_list;
              return <Cell key={idx} x={x} y={y} cellState={cellStateList[idx]} updateCellState={updateCellState} />
            })
          }
        </div>
      </Draggable>
    </div>
  );
}

export default Map;