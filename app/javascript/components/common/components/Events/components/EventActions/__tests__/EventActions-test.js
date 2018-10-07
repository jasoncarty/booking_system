import React from 'react';
import { create } from 'react-test-renderer';

import EventActions from './../index';

jest
  .mock('./../../DeleteEventButton', () => 'DeleteEventButton')
  .mock('./../../CancelEventButton', () => 'CancelEventButton')
  .mock('./../../JoinEventButton', () => 'JoinEventButton');

const defaultProps = {
  adminSection: true,
  onDeleteSuccess: () => {},
  onDeleteError: () => {},
  onCancelError: () => {},
  onUpdateAttendance: () => {},
  onJoinError: () => {},
  attendances: [1, 2, 3],
  id: 1
};

describe('<EventActions />', () => {
  it('matches snapshot when admin section', () => {
    const element = create(<EventActions {...defaultProps} />);
    expect(element).toMatchSnapshot();
  });

  it('matches snapshot when not admin section', () => {
    const props = {
      ...defaultProps,
      adminSection: false
    };
    const element = create(<EventActions {...props} />);
    expect(element).toMatchSnapshot();
  });
});
