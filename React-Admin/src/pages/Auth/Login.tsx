import React from 'react';
import { useNavigate  } from 'react-router-dom';

// material-ui
import {
  Button,
  FormHelperText,
  Grid,
  InputLabel,
  OutlinedInput,
  Stack,
} from '@mui/material';

// third party
import * as Yup from 'yup';
import { Formik } from 'formik';

import useAuth from '@/hooks/useAuth';
import useScriptRef from '@/hooks/useScriptRef';

// ============================|| JWT - LOGIN ||============================ //

const AuthLogin = ({ isDemo = false }: { isDemo?: boolean }) => {

  const navigate = useNavigate();
  const [checked, setChecked] = React.useState(false);

  const  { login }  = useAuth();
  const { isLoggedIn } = useAuth();
  const scriptedRef = useScriptRef();

  const [showPassword, setShowPassword] = React.useState(false);
  const handleClickShowPassword = () => {
    setShowPassword(!showPassword);
  };

  const handleMouseDownPassword = (event: React.SyntheticEvent) => {
    event.preventDefault();
  };
  if(isLoggedIn) navigate("/admin");
  return (
    <div className="relative" style={{display: "flex", justifyContent: "center", alignItems: "center", height: "100vh", backgroundImage: "url(/public/images/loginback.jpg)", backgroundSize: "cover" }}>
      <img src="/src/assets/logo.png" className="top-20 left-20 absolute w-[150px]"></img>
      <Formik
        initialValues={{
          email: 'info@codedthemes.com',
          password: '123456',
          submit: null
        }}
        validationSchema={Yup.object().shape({
          email: Yup.string().email('Must be a valid email').max(255).required('Email is required'),
          password: Yup.string().max(255).required('Password is required')
        })}
        onSubmit={async (values, { setErrors, setStatus, setSubmitting }) => {
          try {
            
            await login(values.email, values.password);
            if(localStorage.getItem("serviceToken"))navigate("/admin");
            if (scriptedRef.current) {
              setStatus({ success: true });
              setSubmitting(false);
            }
          } catch (err: any) {
            console.error(err);
            if (scriptedRef.current) {
              setStatus({ success: false });
              setErrors({ submit: err.message });
              setSubmitting(false);
            }
          }
        }}
      >
        {({ errors, handleBlur, handleChange, handleSubmit, isSubmitting, touched, values }) => (
          <form noValidate onSubmit={handleSubmit} style ={{width: "25vw", boxShadow: "rgba(0, 0, 0, 0.35) 0px 5px 15px", padding: "20px 20px 40px 20px", borderRadius: "10px", backgroundColor: 'rgba(255 255 255)'}}>
            <Grid container spacing={3}>
              <Grid item xs={12}><h1 style={{fontFamily: "serif", fontSize: "30px", textAlign: "center", color: "rgb(0 170 255)"}}>ADMIN PANEL</h1></Grid>
              <Grid item xs={12}>
                <Stack spacing={1}>
                  <InputLabel htmlFor="email-login" sx={{color: "white"}}>Email Address</InputLabel>
                  <OutlinedInput
                    id="email-login"
                    type="email"
                    value={values.email}
                    name="email"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    placeholder="Enter email address"
                    fullWidth
                    error={Boolean(touched.email && errors.email)}
                  />
                  {touched.email && errors.email && (
                    <FormHelperText error id="standard-weight-helper-text-email-login">
                      {errors.email}
                    </FormHelperText>
                  )}
                </Stack>
              </Grid>
              <Grid item xs={12}>
                <Stack spacing={1}>
                  <InputLabel htmlFor="password-login" sx={{color: "white"}}>Password</InputLabel>
                  <OutlinedInput
                    fullWidth
                    error={Boolean(touched.password && errors.password)}
                    id="-password-login"
                    type={showPassword ? 'text' : 'password'}
                    value={values.password}
                    name="password"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    placeholder="Enter password"
                  />
                  {touched.password && errors.password && (
                    <FormHelperText error id="standard-weight-helper-text-password-login">
                      {errors.password}
                    </FormHelperText>
                  )}
                </Stack>
              </Grid>
              <Grid item xs={12}>
                  <Button disableElevation disabled={isSubmitting} fullWidth size="large" type="submit" variant="contained" color="primary">
                  Login
                </Button>
              </Grid>
              {errors.submit && (
                <Grid item xs={12}>
                  <FormHelperText error>{errors.submit}</FormHelperText>
                </Grid>
              )}
            </Grid>
          </form>
        )}
      </Formik>
    </div>
  );
};

export default AuthLogin;
