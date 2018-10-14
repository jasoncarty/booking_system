import React from 'react';
import { Provider } from 'react-redux';
import { createStore } from 'redux';

import reducer from './../Reducers';
import App from './../App';

const Root = (initialState) => {
  const store = createStore(
    reducer,
    initialState,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
  );

  return (
    <Provider store={store}>
      <App />
    </Provider>
  );
};

export default Root;