import React, { Component } from 'react';
import PropTypes from 'prop-types';

import { gravatarUrl } from './../../../../utils';

class EventListAttendees extends Component {
  static propTypes = {
    isReserves: PropTypes.bool,
    attendees: PropTypes.arrayOf(PropTypes.shape({
      user: PropTypes.shape({
        name: PropTypes.string.isRequired,
        email: PropTypes.string.isRequired
      }).isRequired
    })),
    eventId: PropTypes.number.isRequired
  }

  getAttendees = () => {
    const { attendees } = this.props;
    return attendees.map((attendee, index) =>
      <li key={`${attendee.id}-${index}`} className={'event-attendee'}>
        <img
          src={gravatarUrl(attendee.user.email, 40)}
          alt={attendee.user.name}
        />
        <span className="attendee-name">{attendee.user.name}</span>
      </li>
    );
  }

  render() {
    const { isReserves } = this.props;
    const theClass = isReserves ?
      'event-attendees reserves'
      : 'event-attendees not-reserves';

    return (
      <div className={theClass}>
        <div className={'attendees-wrapper'}>
          <ul className={theClass}>
            {this.getAttendees()}
          </ul>
        </div>
      </div>
    );
  }
}

export default EventListAttendees;