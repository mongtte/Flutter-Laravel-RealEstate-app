import axios from 'axios';

const axiosServices = axios.create({baseURL: /*prcess.env.REACT_APP_API_URL |*/ 'https://b2ea-88-99-90-19.ngrok-free.app/' });

// ==============================|| AXIOS - FOR MOCK SERVICES ||============================== //

axiosServices.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response.status === 401 && !window.location.href.includes('/login')) {
      window.location.pathname = '/login';
    }
    return Promise.reject((error.response && error.response.data) || 'Wrong Services');
  }
);

export default axios;
