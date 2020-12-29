import React, { useState } from "react";
import Cell from './Cell';
import "../styles/Map.css";
import test_png from '../images/test_div.png';
import Draggable from 'react-draggable';
import PopupContent from "./PopupContent.js";


const Map = () => {
  const [ popupState, setPopupState ] = useState({
    visible: false,
    type: "None",
    x: -1, 
    y:-1
  });

  const [ reload, setReload ] = useState(false);

  const cellAry = [[10, 10], [130, 50], [380, 270], [280, 100], [40, 300]];

  const setPopup = (visible, type, x, y) => {
    setPopupState({
      visible, type, x, y
    });
  }

  const makeReload = () => {
    setReload(!reload);
  }
  
  // console.log(usrMap);
  return (
    <div className="flex_div" >
      <div className="popup_div" style={{visibility: popupState.visible?"visible":"hidden"}}>
        <PopupContent visible={popupState.visible} type={popupState.type} x={popupState.x} y={popupState.y} setPopup={setPopup} makeReload={makeReload} />
      </div>
      <Draggable>
        <div className="inline_div">
          <img src={test_png} alt="Workplace" className="background_img"/>
          {
            cellAry.map((xy_list, idx) => {
              const [x, y] = xy_list;
              return <Cell key={idx} x={x} y={y} reload={reload} setPopup={setPopup} />
            })
          }
        </div>
      </Draggable>
    </div>
  );
}

export default Map;