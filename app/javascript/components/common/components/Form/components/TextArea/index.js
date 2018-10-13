import React, { Fragment } from 'react';

const TextArea = ({ label, ...rest }) => {
  return (
    <Fragment>
      <label>{label}</label>
      <textarea {...rest} />
    </Fragment>
  );
};

export default TextArea;
