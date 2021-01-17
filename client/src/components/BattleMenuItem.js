import React, { useState, useContext, useEffect } from 'react';
import { ContractContext } from '../App';
import { Menu, Dropdown, Icon } from 'semantic-ui-react';

const BattleMenuItem = ({ userIdx, active, select }) => {
  const state = useContext(ContractContext);
  const [ userPower, setUserPower ] = useState(-1);

  useEffect(() => {
    const { contract, accounts } = state;
    if(!contract || accounts.length < 1) return;
    const getUP = async () => {
      const pow = await contract.methods.getUserPower(userIdx).call({from:accounts[0]});
    }
  }, [state])

  return <>
    <Menu.Item
      active={active}
      onClick={() => select(userIdx)}
    >
      <Menu.Header>{`Player${userIdx}`}</Menu.Header>

      <Menu.Menu>
        <Menu.Item>
          {
            ["power: ",
              userPower === -1 ?
              <Icon key="loading" loading name='spinner' />
              :
              `${userPower}`
            ]
          }
        </Menu.Item>
      </Menu.Menu>
    </Menu.Item>
  </>
}

export default BattleMenuItem;