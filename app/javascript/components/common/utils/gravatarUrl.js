'use-strict';
import md5 from 'md5';

const gravatarUrl = (email, size = null) => {
  const hash = md5(email.trim().toLowerCase());
  return `http://gravatar.com/avatar/${hash}.png?s=${size}&d=wavatar`;
};

export default gravatarUrl;
