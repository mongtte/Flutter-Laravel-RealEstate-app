import ReactDOM from "react-dom/client";
import { Provider } from "react-redux";
import { store } from "@/redux/store.ts";
import App from "./App.tsx";
import "./index.css";
import "toastr/build/toastr.css";
import { JWTProvider as AuthProvider } from "@/contexts/JWTContext";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <Provider store={store}>
    <AuthProvider>
      <App />
    </AuthProvider>
  </Provider>,
);
