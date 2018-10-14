import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

const App = ({ greeting }) => {
  // Add router using PublicRoutes and AdminRoutes
  return (
    <h1>Hello there {greeting}</h1>
  );
};

App.propTypes = {
  greeting: PropTypes.string
};

const mapStateToProps = ({ currentUser }) => ({
  currentUser
});

export default connect(mapStateToProps)(App);
