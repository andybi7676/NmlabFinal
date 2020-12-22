import React from "react";
import Cell from './Cell';
import "../styles/Map.css";


const Map = () => {
  const row = 8;
  const col = 8;
  const usrMap = new Array(row).fill(0).map(() => new Array(col).fill(0).map((_,idx) => idx));
  // console.log(usrMap);
  return (
    <div className="map">
      {
        usrMap.map((ary, row) => (
          <div key={row} className="map_row">
            {
              ary.map((col) => (
                <Cell key={col} x={row} y={col} />
              ))
            }
          </div>
        ))
      }
    </div>
  );
}

export default Map;