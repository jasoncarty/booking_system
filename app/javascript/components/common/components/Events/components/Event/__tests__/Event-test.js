import React from 'react';
import { create } from 'react-test-renderer';

import Event from './../index';

jest
  .mock('./../../EventListAttendees', () => 'EventListAttendees')
  .mock('./../../EventActions', () => 'EventActions');

const defaultProps = {
  id: 1,
  name: 'Fake name',
  description: 'Fake description',
  startsAt: '098739084Tlkjhasdf',
  eventAttendees: [],
  attendances: [1,2,3],
  onDeleteError: () => {},
  onDeleteSuccess: () => {},
  adminSection: true
};

describe('<Event />', () => {
  it('matches snapshot if there no attendees', () => {
    const element = create(<Event {...defaultProps} />);
    expect(element).toMatchSnapshot();
  });

  it('matches snapshot if there are attendees but no reserves', () => {
    const props = {
      ...defaultProps,
      eventAttendees: [
        { reserve: false },
        { reserve: false },
        { reserve: false }
      ]
    };
    const element = create(<Event {...props} />);
    expect(element).toMatchSnapshot();
  });

  it('matches snapshot if there are attendees and reserves', () => {
    const props = {
      ...defaultProps,
      eventAttendees: [
        { reserve: false },
        { reserve: true },
        { reserve: false }
      ]
    };
    const element = create(<Event {...props} />);
    expect(element).toMatchSnapshot();
  });

  it('tests exclusion/inclusion from event', () => {
    const originalAttendees = [
      { reserve: false },
      { reserve: true },
      { reserve: false }
    ];

    const props = {
      ...defaultProps,
      eventAttendees: originalAttendees
    };

    const element = create(<Event {...props} />);
    const instance = element.getInstance();
    expect(instance.state.eventAttendees).toEqual(originalAttendees);

    const { attendances } = defaultProps;
    const newAttendees = [
      { reserve: true },
      { reserve: false }
    ];

    instance.handleUpdateAttendance({
      data: {
        eventAttendees: newAttendees,
        attendances
      }
    });
    expect(instance.state.eventAttendees).toEqual(newAttendees);
  });
});
