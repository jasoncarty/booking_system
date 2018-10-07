import React from 'react';
import { create } from 'react-test-renderer';

import EventListAttendee from './../index';

const defaultProps = {
  isReserves: true,
  attendees: [
    {
      user: {
        name: 'jason carty',
        email: 'jason@email.com'
      }
    }
  ],
  eventId: 1
};

describe('<EventListAttendee />', () => {
  it('matches snapshot when isReserves', () => {
    const element = create(<EventListAttendee {...defaultProps} />);
    expect(element).toMatchSnapshot();
  });

  it('matches snapshot when !isReserves', () => {
    const props = {
      ...defaultProps,
      isReserves: false
    };
    const element = create(<EventListAttendee {...props} />);
    expect(element).toMatchSnapshot();
  });
});
