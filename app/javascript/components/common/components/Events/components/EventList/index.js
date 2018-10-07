import React, { Component } from 'react';
import PropTypes from 'prop-types';

import Event from './../Event';

class EventList extends Component {
  static propTypes = {
    events: PropTypes.arrayOf(
      PropTypes.shape({})
    ).isRequired,
    adminSection: PropTypes.bool,
    attendances: PropTypes.arrayOf(PropTypes.number)
  }

  state = {
    events: []
  }

  componentDidMount() {
    this.setState({
      events: this.props.events
    });
  }

  handleDeleteEventSuccess = ({ data: { eventId }}) => {
    const events = this.state.events;
    this.setState({
      events: events.filter((event) => event.id.toString() !== eventId)
    });
  }

  handleDeleteEventError = (error) =>
    console.log(error, '----------------')

  getEvents = () => {
    const { events } = this.state;

    return events.map((event, index) => {
      const {
        name,
        description,
        starts_at,
        id,
        event_attendees: eventAttendees,
      } = event;

      const {
        adminSection,
        attendances
      } = this.props;

      return (
        <Event
          key={`${name}.${index}`}
          name={name}
          id={id}
          description={description}
          startsAt={starts_at}
          eventAttendees={eventAttendees}
          attendances={attendances}
          onDeleteSuccess={this.handleDeleteEventSuccess}
          onDeleteError={this.handleDeleteEventError}
          adminSection={adminSection}
        />
      );
    });
  }

  render() {
    return (
      <div id="event-container">
        <h1>Events</h1>
        <div className="spacer-25" />
        {this.getEvents()}
      </div>
    );
  }
}

export default EventList;
