import axios from 'axios';

import csrfToken from './csrfToken';

const sendRequest = ({
  type,
  url,
  options = {},
  onSuccess,
  onError
}) => {
  axios[type](`${url}?authenticity_token=${encodeURIComponent(csrfToken())}`, {
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken(),
      'X-Requested-With': 'XMLHttpRequest'
    },
    ...options
  })
    .then(onSuccess)
    .catch(onError);
};

export default sendRequest;
