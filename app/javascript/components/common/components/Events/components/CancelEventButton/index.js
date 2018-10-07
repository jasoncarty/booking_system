import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { sendRequest } from './../../../../utils';

class CancelEventButton extends Component {
  static propTypes = {
    onSuccess: PropTypes.func.isRequired,
    onError: PropTypes.func.isRequired,
    id: PropTypes.number.isRequired
  }

  handleClick = () => {
    const {
      id,
      onSuccess,
      onError
    } = this.props;

    sendRequest({
      url: `/events/${id}/cancel`,
      type: 'post',
      onSuccess,
      onError
    });
  }

  render() {
    return (
      <button
        type="button"
        className="btn btn-red btn-center"
        onClick={this.handleClick}
      >
        No longer interested
      </button>
    );
  }
}

export default CancelEventButton;
