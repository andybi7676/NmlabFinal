import React, { useState, useContext, useEffect } from "react";
import { ContractContext } from "../App";
import { Modal } from 'semantic-ui-react';
import "../styles/Map.css";
import { None, Farm, Sawmill, Mine, Manor, Quarry } from './ModalComponents/index';

const ModalContent = ({ x, y, type, index, makeReload }) => {
  const state = useContext(ContractContext);

  if(type === "None") {
    return <>
      <Modal.Header>Create Buiding</Modal.Header>
      {state.accounts && state.contract ? <None x={x} y={y} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }
  if(type === "Farm") {
    return <>
      <Modal.Header>Farm</Modal.Header>
      {state.accounts && state.contract ? <Farm x={x} y={y} index={index} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }
  if(type === "Sawmill") {
    return <>
      <Modal.Header>Sawmill</Modal.Header>
      {state.accounts && state.contract ? <Sawmill x={x} y={y} index={index} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }
  if(type === "Mine") {
    return <>
      <Modal.Header>Mine</Modal.Header>
      {state.accounts && state.contract ? <Mine x={x} y={y} index={index} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }
  if(type === "Manor") {
    return <>
      <Modal.Header>Manor</Modal.Header>
      {state.accounts && state.contract ? <Manor x={x} y={y} index={index} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }
  if(type === "Quarry") {
    return <>
      <Modal.Header>Manor</Modal.Header>
      {state.accounts && state.contract ? <Quarry x={x} y={y} index={index} contract={state.contract} account={state.accounts[0]} makeReload={makeReload} /> : null}
    </>
  }

  return <></>
  
}

export default ModalContent;