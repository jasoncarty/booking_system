'use-strict';

const csrfToken = () =>
  document.querySelector('[name="csrf-token"]').content;

export default csrfToken;
