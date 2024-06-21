import { configureStore } from "@reduxjs/toolkit";
import { useDispatch as useAppDispatch, useSelector as useAppSelector, TypedUseSelectorHook } from 'react-redux';
import rootReducer from "./reducers/index";
import { persistStore } from 'redux-persist';

const store = configureStore({
  reducer: rootReducer,
  devTools: process.env.NODE_ENV !== 'production',
});

export type RootState = ReturnType<typeof rootReducer>;

export type AppDispatch = typeof store.dispatch;

const persister = persistStore(store);

const { dispatch } = store;

const useDispatch = () => useAppDispatch<AppDispatch>();
const useSelector: TypedUseSelectorHook<RootState> = useAppSelector;

export { store, dispatch, persister, useSelector, useDispatch };
