import React from 'react';
import { create } from 'react-test-renderer';

import EventList from './../index';

jest.mock('./../../Event', () => 'Event');

const defaultProps = {
  events: [
    { id: 1 },
    { id: 2 },
    { id: 3 }
  ]
};

describe('<EventList />', () => {
  it('matchesSnapshot with default props', () => {
    const element = create(<EventList {...defaultProps} />);
    expect(element).toMatchSnapshot();
  });

  it('deletes the event and changes state', () => {
    const element = create(<EventList {...defaultProps} />);
    const instance = element.getInstance();
    expect(instance.state.events).toEqual(defaultProps.events);

    instance.handleDeleteEventSuccess({
      data: {
        eventId: '1'
      }
    });

    expect(element).toMatchSnapshot();
    expect(instance.state.events).toEqual([
      { id: 2 },
      { id: 3 }
    ]);
  });
});
