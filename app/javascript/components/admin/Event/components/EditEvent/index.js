import React, { Component, Fragment } from 'react';
import PropTypes from 'prop-types';
import idx from 'idx';

import {
  Input,
  TextArea
} from './../../../../common/components/Form';

const FIELDS = [
  {
    name: {
      component: Input,
      label: 'name',
      className: 'form-control'
    },
    description: {
      component: TextArea,
      label: 'description',
      className: 'form-control'
    },
    'starts_at': {
      component: Input,
      label: 'Starts at',
      className: 'form-control datepicker hasDatepicker'
    },
    'maximum_event_attendees': {
      component: Input,
      label: 'Maximum event attendees',
      className: 'form-control'
    }
  }
];

class EditEvent extends Component {
  static propTypes = {
    event: PropTypes.shape({
      name: PropTypes.string.isRequired,
      description: PropTypes.string,
      'starts_at': PropTypes.string.isRequired,
      'maximum_event_attendees': PropTypes.number
    })
  }

  formatDate = (date) => {
    const options = {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    };
    return new Date(date).toLocaleDateString('en-ZA', options);
  }

  getFieldType = (key) => {
    switch(key) {
    case 'starts_at':
      return 'date';
    case 'description':
      return null;
    default:
      return 'text';
    }
  }

  getValue = (key) => {
    if (key === 'starts_at') {
      return this.formatDate(this.props.event['starts_at']);
    }
    return idx(this.props, _ => _.event[key]);
  }

  getFields = () =>
    FIELDS.map((field) =>
      Object.keys(field).map((key) => {
        const Field = field[key].component;
        const { className, label } = field[key];
        return (
          <div className="form-group" key={`${key}-${label}`}>
            <Field
              name={key}
              className={className}
              label={label}
              defaultValue={this.getValue(key)}
              type={this.getFieldType(key)}
            />
          </div>
        );
      })
    )

  render() {
    return (
      <Fragment>
        <h1>Edit Event</h1>
        <form onSubmit={this.handleSubmit}>
          {this.getFields()}
        </form>
      </Fragment>
    );
  }
}

export default EditEvent;
