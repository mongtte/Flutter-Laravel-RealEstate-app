import React, { createContext, useEffect, useReducer } from 'react';

// third-party
import { Chance } from 'chance';
import {jwtDecode} from 'jwt-decode';

// reducer - state management
import { LOGIN, LOGOUT } from '@/redux/actions/AuthActions';
import authReducer from '@/redux/reducers/AuthReducer';

// project import
import Loader from '../components/Loader';
// import axios from '@/utils/axios';
import { myAxios } from '../redux/actions/Constants';
import { KeyedObject } from '@/types/root';
import { AuthProps, JWTContextType } from '@/types/auth';
import toastr from "toastr";

const chance = new Chance();

// constant
const initialState: AuthProps = {
  isLoggedIn: false,
  isInitialized: false,
  user: null
};

const verifyToken: (st: string) => boolean = (serviceToken) => {
  if (!serviceToken) {
    return false;
  }
  const decoded: KeyedObject = jwtDecode(serviceToken);
  /**
   * Property 'exp' does not exist on type '<T = unknown>(token: string, options?: JwtDecodeOptions | undefined) => T'.
   */
  return decoded.exp > Date.now() / 1000;
};

const setSession = (serviceToken?: string | null) => {
  if (serviceToken) {
    localStorage.setItem('serviceToken', serviceToken);
    myAxios.defaults.headers.common.Authorization = `Bearer ${serviceToken}`;
  } else {
    localStorage.removeItem('serviceToken');
    delete myAxios.defaults.headers.common.Authorization;
  }
};

// ==============================|| JWT CONTEXT & PROVIDER ||============================== //

const JWTContext = createContext<JWTContextType | null>(null);

export const JWTProvider = ({ children }: { children: React.ReactElement }) => {

  const [state, dispatch] = useReducer(authReducer, initialState);

  useEffect(() => {
    const init = async () => {
      try {
        const serviceToken = window.localStorage.getItem('serviceToken');
        if (serviceToken && verifyToken(serviceToken)) {
          setSession(serviceToken);
          // const response = await myAxios.get('/api/account/me');
          // const { user } = response.data;

          dispatch({
            type: LOGIN,
            payload: {
              isLoggedIn: true,
              // user
            }
          });
        } else {
          dispatch({
            type: LOGOUT
          });
        }
      } catch (err) {
        console.error(err);
        dispatch({
          type: LOGOUT
        });
      }
    };

    init();
  }, []);

  const login = async (email: string, password: string) => {
    
    const response = await myAxios.post('/admin/login', { email, password });
    // console.log(response.data);
    if(response.data.jwt) {
      toastr.success("Successfully Login");
      setSession(response.data.jwt);
      dispatch({
        type: LOGIN,
        payload: {
          isLoggedIn: true,
          // user
        }
      });
    }
    else {
      toastr.warning("Wrong email or password")
    }
    // const { serviceToken, user } = response.data;
  };

  // const loginWithToken = async () => {
    
  //   const token = localStorage.getItem("serviceToken");
  //   const response = await myAxios.post('/admin/login-with-token', { token: token });
  //   // console.log(response.data);
  //   if(response.data === "ok") {
      
  //     dispatch({
  //       type: LOGIN,
  //       payload: {
  //         isLoggedIn: true,
  //         // user
  //       }
  //     });
  //   }
  //   else {
  //     toastr.warning("Token expired")
  //   }
  //   // const { serviceToken, user } = response.data;
  // };

  const register = async (email: string, password: string, firstName: string, lastName: string) => {
    // todo: this flow need to be recode as it not verified
    const id = chance.bb_pin();
    const response = await myAxios.post('/api/account/register', {
      id,
      email,
      password,
      firstName,
      lastName
    });
    let users = response.data;

    if (window.localStorage.getItem('users') !== undefined && window.localStorage.getItem('users') !== null) {
      const localUsers = window.localStorage.getItem('users');
      users = [
        ...JSON.parse(localUsers!),
        {
          id,
          email,
          password,
          name: `${firstName} ${lastName}`
        }
      ];
    }

    window.localStorage.setItem('users', JSON.stringify(users));
  };

  const logout = () => {
    setSession(null);
    dispatch({ type: LOGOUT });
  };

  // const resetPassword = async (email: string) => {};

  // const updateProfile = () => { };

  if (state.isInitialized !== undefined && !state.isInitialized) {
    return <Loader />;
  }

  return <JWTContext.Provider value={{ ...state, login, logout, register /*resetPassword,updateProfile*/ }}>{children}</JWTContext.Provider>;
};

export default JWTContext;
