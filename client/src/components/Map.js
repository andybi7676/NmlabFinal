import React, { useState, useEffect, useContext } from "react";
import { ContractContext } from "../App";
import { useMeasure } from 'react-use'
import Cell from './Cell';
import "../styles/Map.css";
import gameBackground from '../images/gameBackground2.jpg';
import Draggable from 'react-draggable';


const imgWidth = 1311;
const imgHeight = 646;
const cellAry = [[10, 10], [130, 50], [380, 270], [280, 100], [40, 300], [650, 300], [800, 600], [1000, 300], [900, 100], [700, 400]];

const Map = () => {
  const state = useContext(ContractContext);
  const [ ref, { width, height } ] = useMeasure();
  const [ initialized, setInitialized ] = useState(false);
  const [ cellStateList, setCellStateList ] = useState([]);
  const [ upgradingIdx, setUpgradingIdx ] = useState(0);
  const [ reload, setReload ] = useState(false);
  // console.log(width, height);

  const updateCellState = (idx, newState) => {
    console.log("update: ", idx);
    console.log(newState);
    setCellStateList([ ...cellStateList.slice(0, idx), newState, ...cellStateList.slice(idx+1)]);
    if(newState.upgrade) {
      if(upgradingIdx === 0) {
        setUpgradingIdx(idx);
      }
    }
    if(newState.upgrade === false) {
      setUpgradingIdx(0);
    }
  }

  const updateProgress = () => {
    if(upgradingIdx === 0) {
      return;
    }
    console.log(upgradingIdx);
    const [ a, b ] = cellStateList[upgradingIdx].upgrade;
    console.log(a, b);
    if(a < b) {
      const newState = { ...cellStateList[upgradingIdx], upgrade: [a + 3, b] };
      updateCellState(upgradingIdx, newState);
    }
    else {
      setUpgradingIdx(0);
    }
  }

  const callUpdateProgress = () => {
    if(upgradingIdx === 0) {
      return;
    }
    updateProgress();
    setReload(!reload);
  }

  useEffect(() => {
    const { contract, accounts } = state;
    let upgIdx = 0;
    const load = async (x, y, idx, upgradingId) => {
      const building = await contract.methods.getBuildingByOwner(accounts[0], x, y).call({from: accounts[0]});
      const loadIndex = parseInt(building[0]);
      const loadType = building[1];
      if(loadIndex === upgradingId && upgradingId !== 0) {
        const remainTime = parseInt( await contract.methods.getRemainingTime(accounts[0]).call({from: accounts[0]}) );
        if(remainTime < 1000) {
          console.log(idx);
          upgIdx = idx;
          return { type: loadType, index: loadIndex, upgrade: [0, remainTime] }
        }
        upgIdx = 0;
      }
      return { type: loadType, index: loadIndex };
    }
    const init = async () => {
      const upgradingId = parseInt( await contract.methods.getUpgradingId(accounts[0]).call({from: accounts[0]}) );
      console.log(upgradingId);
      Promise.all(cellAry.map((val, idx) => {
        return load(val[0], val[1], idx, upgradingId);
      })).then(result => {
        console.log(result);
        setCellStateList(result);
        setInitialized(true);
        setUpgradingIdx(upgIdx);
        // updateProgress();
      })
    }
    if(contract && accounts.length > 0) {
      if(!initialized) {
        init();
      }
    }
    if(upgradingIdx !== 0) {
      setTimeout(() => {
        callUpdateProgress();
      }, 3000);
    }
  }, [state, upgradingIdx, reload])

  const boundStyle = {left: -(imgWidth - width)/2, right: (imgWidth - width)/2, top: -(imgHeight - height), bottom: 0 };
  
  return (
    // <CellStateContext.Provider value={cellStateList}>
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
                return <Cell key={idx} idx={idx} x={x} y={y} initialized={initialized} cellState={cellStateList[idx]} updateCellState={updateCellState} />
              })
            }
          </div>
        </Draggable>
      </div>
    // </CellStateContext.Provider>
  );
}

export default Map;