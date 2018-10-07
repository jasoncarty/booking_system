import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';

import DeleteEventButton from './../DeleteEventButton';
import CancelEventButton from './../CancelEventButton';
import JoinEventButton from './../JoinEventButton';

class EventActions extends Component {
  static propTypes = {
    adminSection: PropTypes.bool,
    onDeleteSuccess: PropTypes.func.isRequired,
    onDeleteError: PropTypes.func.isRequired,
    onCancelError: PropTypes.func.isRequired,
    onUpdateAttendance: PropTypes.func.isRequired,
    onJoinError: PropTypes.func.isRequired,
    attendances: PropTypes.arrayOf(PropTypes.number),
    id: PropTypes.number.isRequired
  }

  render() {
    const {
      adminSection,
      onDeleteSuccess,
      onDeleteError,
      id
    } = this.props;

    if (adminSection) {
      return (
        <Fragment>
          <DeleteEventButton
            eventId={id}
            onSuccess={onDeleteSuccess}
            onError={onDeleteError}
          />
          <div className="go-to-event-button">
            <a href={`/admin/events/${id}/edit`}>
              <i className='glyphicon glyphicon-chevron-right'></i>
            </a>
          </div>
        </Fragment>
      );
    }

    const {
      attendances,
      onUpdateAttendance,
      onCancelError,
      onJoinError
    } = this.props;

    return (
      <div className="row spacer-25 actions">
        <div className="col-sm-12">
          {attendances && attendances.includes(id) ? (
            <CancelEventButton
              onSuccess={onUpdateAttendance}
              onError={onCancelError}
              id={id}
            />
          ) : (
            <JoinEventButton
              onSuccess={onUpdateAttendance}
              onError={onJoinError}
              id={id}
            />
          )}
        </div>
      </div>
    );
  }
}

export default EventActions;
