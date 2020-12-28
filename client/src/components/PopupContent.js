import React, { useState } from "react";

const PopupContent = ({ type }) => {

  let content;

  switch (type) {
    case "none":
      content = <>
        This is content for type none.
      </>;
      break;
    case "farm":
      content = <>
        This is content for type farm.
      </>;
    default:
      content = <></>
      break;
  }

  return content;
}

export default PopupContent;