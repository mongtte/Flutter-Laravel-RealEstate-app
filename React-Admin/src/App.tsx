import { FC } from "react";
import { Navigate } from "react-router-dom";
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import { Layout } from "./Layout";

import Admin from "./pages/Admin/Admin.tsx";
import Login from "./pages/Auth/Login.tsx";
import AuthGuard from "./utils/route-guard/AuthGuard.tsx";


const router = createBrowserRouter([
  {
    path: "/",
    element: (<AuthGuard><Layout /></AuthGuard>),
    children: [
      {
        path: "/",
        element: <Navigate to="/admin" />
      },
      {
        path: "/admin",
        element: (<Admin />)
      },
      {
        path: "/login",
        element: <Login />
      }
    ],
  },
]);

const App: FC = () => {

  return (
    <RouterProvider router={router} />
  );
};

export default App;
