import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { sendRequest } from './../../../../utils';

class JoinEventButton extends Component {
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
      url: `/events/${id}/book`,
      type: 'post',
      onSuccess,
      onError
    });
  }

  render() {
    return (
      <button
        type="button"
        className="btn btn-blue btn-center"
        onClick={this.handleClick}
      >
        Join in
      </button>
    );
  }
}

export default JoinEventButton;
