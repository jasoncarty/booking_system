import React, { Fragment } from 'react';

const Input = ({ label, ...rest }) => {
  return (
    <Fragment>
      <label>{label}</label>
      <input {...rest} />
    </Fragment>
  );
};

export default Input;
