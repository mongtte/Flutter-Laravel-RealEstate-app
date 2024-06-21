import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import RegisterManagement from "@/components/Admin/RegisterManagement/RegisterManagement";
import CategoryManagement from "@/components/Admin/CategoryManagement/CategoryManagement";
import SubCategoryManagement from "@/components/Admin/SubCategoryManagement/SubCategoryManagement";
import ProductsManagement from "@/components/Admin/ProductsManagement/ProductsManagement";
import UserManagement from "@/components/Admin/UserManagement/UserManagement";
import MultimediaManagement from "@/components/Admin/MultimediaManagement/MultimediaManagement";
import LikesManagement from "@/components/Admin/LikesManagement/LikesManagement";
import RoomManagement from "@/components/Admin/RoomManagement/RoomManagement";
import MessagesManagement from "@/components/Admin/MessagesManagement/MessagesManagement";
import ApproveManagement from "@/components/Admin/ApproveManagement/ApproveManagement";
import AdminUserManagement from "@/components/Admin/AdminUserManagement/AdminUserManagement";
import PaymentManagement from "@/components/Admin/PaymentManagement/PaymentManagement";
import ServiceManagement from "@/components/Admin/ServiceManagement/ServiceManagement";
import PersonIcon from "@mui/icons-material/Person";
import CategoryIcon from "@mui/icons-material/Category";
import ProductionQuantityLimitsIcon from "@mui/icons-material/ProductionQuantityLimits";
import QrCodeIcon from "@mui/icons-material/QrCode";
import GroupAddIcon from "@mui/icons-material/GroupAdd";
import PlayLessonIcon from "@mui/icons-material/PlayLesson";
import FamilyRestroomIcon from "@mui/icons-material/FamilyRestroom";
import ContactMailIcon from "@mui/icons-material/ContactMail";
import AdminPanelSettingsIcon from "@mui/icons-material/AdminPanelSettings";
import FavoriteIcon from "@mui/icons-material/Favorite";
import BalanceIcon from "@mui/icons-material/Balance";
import PaidIcon from "@mui/icons-material/Paid";
import SupportAgentIcon from "@mui/icons-material/SupportAgent";
import Carousell from "@/components/Carousel";



const btn_name = [
  "Approve Publish",
  "Payment",
  "ServiceManagement",
  "Register",
  "Category",
  "SubCategory",
  "Product",
  "User",
  "Multimedia",
  "Likes",
  "Room",
  "Messages",
  "AdminManagement",
];

const Admin = () => {
  const navigate = useNavigate();
  const [btnId, setBtnId] = useState<number>(0);


  const handleClick = (index: number) => {
    setBtnId(index);
  };

  const handleLogout = () => {
    localStorage.removeItem("serviceToken");
    navigate("/login");
  };

  return (
    <>
      <div className="w-full">
        <div className="relative flex w-full">
          <button
            className="absolute right-10 top-48 z-10 h-[40px] w-[100px] rounded bg-success text-lg  text-white"
            onClick={handleLogout}
          >
            Logout
          </button>
          <div className="relative flex h-screen w-[300px] flex-col border-r border-gray-200 bg-white pt-5">
            <div style={{ height: "150px" }}>
              <img
                src="/src/assets/logo1.png"
                className="absolute left-8 top-3 ml-4 mt-4 h-32 w-32"
              />
            </div>

            {btn_name.map((item, index) => {
              return (
                <button
                  key={index}
                  className={`mt-5 h-10 w-[300px] font-serif text-xl ${
                    btnId === index ? "text-white" : "text-black"
                  } flex items-center pl-10 text-left hover:bg-green-400 ${
                    btnId === index ? "bg-green-400" : ""
                  }`}
                  onClick={() => handleClick(index)}
                >
                  {item === "Approve Publish" ? (
                    <BalanceIcon className="mr-3" />
                  ) : item === "Payment" ? (
                    <PaidIcon className="mr-3" />
                  ) : item === "ServiceManagement" ? (
                    <SupportAgentIcon className="mr-3" />
                  ) : item === "Register" ? (
                    <PersonIcon className="mr-3" />
                  ) : item === "Category" ? (
                    <CategoryIcon className="mr-3" />
                  ) : item === "SubCategory" ? (
                    <ProductionQuantityLimitsIcon className="mr-3" />
                  ) : item === "Product" ? (
                    <QrCodeIcon className="mr-3" />
                  ) : item === "User" ? (
                    <GroupAddIcon className="mr-3" />
                  ) : item === "Multimedia" ? (
                    <PlayLessonIcon className="mr-3" />
                  ) : item === "Likes" ? (
                    <FavoriteIcon className="mr-3" />
                  ) : item === "Room" ? (
                    <FamilyRestroomIcon className="mr-3" />
                  ) : item === "Messages" ? (
                    <ContactMailIcon className="mr-3" />
                  ) : item === "AdminManagement" ? (
                    <AdminPanelSettingsIcon className="mr-3" />
                  ) : null}{" "}
                  &nbsp;&nbsp;&nbsp;
                  {item}
                </button>
              );
            })}
          </div>
          <div className="align-center flex w-full flex-col">
            <div style={{ height: "250px" }}>
              <Carousell />
            </div>
            <div
              style={{
                display: "flex",
                justifyContent: "center",
                width: "100%",
              }}
            >
              {btnId === 0 && <ApproveManagement />}
              {btnId === 1 && <PaymentManagement />}
              {btnId === 2 && <ServiceManagement />}
              {btnId === 3 && <RegisterManagement />}
              {btnId === 4 && <CategoryManagement />}
              {btnId === 5 && <SubCategoryManagement />}
              {btnId === 6 && <ProductsManagement />}
              {btnId === 7 && <UserManagement />}
              {btnId === 8 && <MultimediaManagement />}
              {btnId === 9 && <LikesManagement />}
              {btnId === 10 && <RoomManagement />}
              {btnId === 11 && <MessagesManagement />}
              {btnId === 12 && <AdminUserManagement />}
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Admin;
