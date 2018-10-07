import React from 'react';
import { create } from 'react-test-renderer';
import CancelEventButton from './../index';

const mockSendRequest = jest.fn();
jest.mock('./../../../../../utils/sendRequest', () => () => mockSendRequest);

const defaultProps = {
  onSuccess: () => {},
  onError: () => {},
  id: 1
};

describe('<CancelEventButton/>', () => {
  it('matches snapshot with default props', () => {
    const element = create(
      <CancelEventButton {...defaultProps} />
    );
    expect(element).toMatchSnapshot();
  });

  it('calls sendRequest', () => {
    const element = create(
      <CancelEventButton {...defaultProps} />
    );
    const instance = element.getInstance();
    const {
      onSuccess,
      onError,
      id
    } = defaultProps;

    instance.handleClick();
    setTimeout(() => {
      expect(mockSendRequest).toBeCalledWith({
        url: `/events/${id}/cancel`,
        type: 'post',
        onSuccess,
        onError
      });
    }, 0);
  });
});
