import React from 'react';
import jsdom from 'jsdom';
import { create } from 'react-test-renderer';

import DeleteEventButton from './../index';

const { JSDOM } = jsdom;
const dom = new JSDOM('<!doctype html><html><body><div id="root"></div></body></html>');
global.window = dom.window;
global.window.confirm = jest.fn();

const mockSendRequest = jest.fn();
jest.mock('./../../../../../utils/sendRequest', () => () => mockSendRequest);

const defaultProps = {
  onSuccess: () => {},
  onError: () => {},
  eventId: 1
};

describe('<DeleteEventButton />', () => {
  it('matches snapshot with default props', () => {
    const element = create(
      <DeleteEventButton {...defaultProps} />
    );
    expect(element).toMatchSnapshot();
  });

  it('calls sendRequest', () => {
    const element = create(
      <DeleteEventButton {...defaultProps} />
    );
    const instance = element.getInstance();
    const {
      onSuccess,
      onError,
      eventId
    } = defaultProps;

    instance.handleClick();
    setTimeout(() => {
      expect(mockSendRequest).toBeCalledWith({
        url: `/admin/events/${eventId}`,
        type: 'delete',
        onSuccess,
        onError
      });
    }, 0);
  });
});
