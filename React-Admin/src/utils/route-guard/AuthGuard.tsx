import { useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";

// project import
import useAuth from "@/hooks/useAuth";

// types
import { GuardProps } from "@/types/auth";

// ==============================|| AUTH GUARD ||============================== //

const AuthGuard = ({ children }: GuardProps) => {
  const { isLoggedIn } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    if (!isLoggedIn) {
      navigate("login", {
        state: {
          from: location.pathname,
        },
        replace: true,
      });
    } else {
      navigate("admin", {
        state: {
          from: location.pathname,
        },
        replace: true,
      });
    }
  }, []);

  return children;
};

export default AuthGuard;
