import React from "react";
import Cell from './Cell';
import "../styles/Map.css";
import mp_img from "../images/background.jpg";
import test_png from '../images/test_div.png';
import { Button } from "semantic-ui-react";
import Draggable from 'react-draggable';


const Map = () => {
  const row = 8;
  const col = 8;
  const usrMap = new Array(row).fill(0).map(() => new Array(col).fill(0).map((_,idx) => idx));
  const cellAry = [[10, 10], [130, 50], [380, 270]];
  // console.log(usrMap);
  return (
    <div className="flex_div" >
      <Draggable>
        <div className="inline_div">
          <img src={test_png} alt="Workplace" className="background_img"/>
          {
            cellAry.map((xy_list, idx) => {
              const [x, y] = xy_list;
              return <Cell key={idx} x={x} y={y} />
            })
          }
        </div>
      </Draggable>
    </div>
  );
}

export default Map;