import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';

import EventListAttendees from './../EventListAttendees';
import EventActions from './../EventActions';

class Event extends Component {
  static propTypes = {
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    description: PropTypes.string,
    startsAt: PropTypes.string.isRequired,
    eventAttendees: PropTypes.arrayOf(PropTypes.shape({})),
    attendances: PropTypes.arrayOf(PropTypes.number),
    onDeleteSuccess: PropTypes.func.isRequired,
    onDeleteError: PropTypes.func.isRequired,
    adminSection: PropTypes.bool
  }

  state = {
    eventAttendees: [],
    attendances: []
  }

  componentDidMount() {
    this.setState({
      eventAttendees: this.props.eventAttendees,
      attendances: this.props.attendances
    });
  }

  getReserves = (eventAttendees) =>
    eventAttendees.filter((attendee) => attendee.reserve);

  getAttendees = (eventAttendees) =>
    eventAttendees.filter((attendee) => !attendee.reserve);

  handleUpdateAttendance = ({ data: { eventAttendees, attendances } }) =>
    this.setState({ eventAttendees, attendances })

  handleCancelError = (res) =>
    console.log('---handleCancelError----', res)

  handleJoinError = (res) =>
    console.log('---handleJoinError----', res)

  render() {
    const {
      id,
      name,
      description,
      startsAt,
      adminSection,
      onDeleteSuccess,
      onDeleteError,
    } = this.props;

    const {
      eventAttendees,
      attendances
    } = this.state;

    const reserves = this.getReserves(eventAttendees);
    const attendees = this.getAttendees(eventAttendees);

    return (
      <div className={'event'} data-event-id={id}>
        <h4>{name}</h4>
        <p>{description }</p>
        <p><b>{`Start: ${startsAt.split('T')[0]}`}</b></p>
        {attendees && attendees.length > 0 && (
          <Fragment>
            <h5>Attendees</h5>
            <EventListAttendees attendees={attendees} isReserves={false} eventId={id} />
          </Fragment>
        )}
        {reserves && reserves.length > 0 && (
          <Fragment>
            <h5 className="spacer-15">Reserves</h5>
            <EventListAttendees attendees={reserves} isReserves={true} eventId={id} />
          </Fragment>
        )}
        <EventActions
          adminSection={adminSection}
          onDeleteSuccess={onDeleteSuccess}
          onDeleteError={onDeleteError}
          onUpdateAttendance={this.handleUpdateAttendance}
          onCancelError={this.handleCancelError}
          onJoinError={this.handleJoinError}
          attendances={attendances}
          id={id}
        />
      </div>
    );
  }
}

export default Event;
