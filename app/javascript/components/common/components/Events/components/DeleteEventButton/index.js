import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { sendRequest } from './../../../../utils';

const CONFIRM_MESSAGE = 'Are you sure you want to delete this event?';

class DeleteEventButton extends Component {
  static propTypes = {
    eventId: PropTypes.number.isRequired,
    onSuccess: PropTypes.func.isRequired,
    onError: PropTypes.func.isRequired
  }

  handleDeleteEvent = () => {
    const {
      eventId,
      onSuccess,
      onError
    } = this.props;

    sendRequest({
      url: `/admin/events/${eventId}`,
      type: 'delete',
      onSuccess,
      onError
    });
  }

  handleClick = () => {
    const confirm = window.confirm(CONFIRM_MESSAGE);
    if (confirm) {
      this.handleDeleteEvent();
    }
  }

  render() {
    return (
      <div className="delete-link" onClick={this.handleClick}>
        <button type="button">
          <i className='glyphicon glyphicon-trash'></i>
        </button>
      </div>
    );
  }
}

export default DeleteEventButton;
