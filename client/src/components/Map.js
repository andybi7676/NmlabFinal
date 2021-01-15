import React, { useState } from "react";
import { useMeasure } from 'react-use'
import Cell from './Cell';
import "../styles/Map.css";
import gameBackground from '../images/gameBackground.jpg';
import Draggable from 'react-draggable';


const imgWidth = 1561;
const imgHeight = 798;
const Map = () => {
  const [ref, { width, height }] = useMeasure();
  const [ reload, setReload ] = useState(false);

  const cellAry = [[10, 10], [130, 50], [380, 270], [280, 100], [40, 300], [800, 500], [1000, 300], [900, 100], [700, 400]];

  const makeReload = () => {
    setReload(!reload);
  }
  console.log(width, height);

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
              return <Cell key={idx} x={x} y={y} reload={reload} />
            })
          }
        </div>
      </Draggable>
    </div>
  );
}

export default Map;