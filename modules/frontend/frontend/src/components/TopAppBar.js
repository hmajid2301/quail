import React, { useContext } from 'react';

import { makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Button from '@material-ui/core/Button';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import Switch from '@material-ui/core/Switch';
import Brightness4Icon from '@material-ui/icons/Brightness4';

import { CustomThemeContext } from '../themes/CustomThemeProvider';
import { getUsernameFromJWT, getGroupFromJWT } from '../utils';
import logo from '../logo.png';

const useStyles = makeStyles(() => ({
  root: {
    flexGrow: 1,
  },
  toolbar: {
    justifyContent: 'space-between',
  },
  logoButton: {
    backgroundColor: 'transparent',
    border: 0,
    cursor: 'pointer',
    outline: 0,
  },
  logo: {
    height: 28,
  },
  toggleIcon: {
    'margin-top': 5,
  },
  username: {
    'font-weight': 'bold',
  },
}));

export default function TopAppBar(props) {
  const classes = useStyles();

  const { onLogout, onReload } = props;
  const username = getUsernameFromJWT();
  const group = getGroupFromJWT();

  const { currentTheme, setTheme } = useContext(CustomThemeContext);
  const isDark = Boolean(currentTheme === 'dark');

  const handleThemeChange = (event) => {
    const { checked } = event.target;
    if (checked) {
      setTheme('dark');
    } else {
      setTheme('light');
    }
  };

  return (
    <AppBar position="static" className={classes.appBar}>
      <Toolbar className={classes.toolbar}>
        <button type="button" onClick={onReload} className={classes.logoButton}>
          <img src={logo} alt="Logo" className={classes.logo} />
        </button>
        <span>
          {/* eslint-disable-next-line react/jsx-one-expression-per-line */}
          Logged in as: <span className={classes.username}>{username} ({group})</span>
        </span>
        <div>
          <FormControlLabel
            control={<Switch checked={isDark} onChange={handleThemeChange} />}
            label={<Brightness4Icon className={classes.toggleIcon} />}
          />
          <Button onClick={onLogout} color="inherit">Logout</Button>
        </div>
      </Toolbar>
    </AppBar>
  );
}
