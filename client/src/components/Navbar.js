import React, { Component } from "react";
import { Dropdown, Menu, Image, Button, Sidebar, Responsive, Icon } from 'semantic-ui-react';
import "../styles/Navbar.css";


const Navbar = ({ contract }) => { 
  return (
    <div className="navbar">
      <Menu secondary className="welcome-menu">
        <Menu.Item
          name='general'
          style={{ color: 'blue' }}
        >
        </Menu.Item>
      </Menu>

    </div>


  )

}


export default Navbar;