import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
import RemoveModal from "./RemoveModal";
import UpdateModal from "./UpdateModal";
// import { TextField } from "@mui/material";
// import Button from '@mui/material/Button';
import "../../style.css";

interface DType {
  key: number;
  id: number;
  lastname: string;
  username: string;
  email: string;
  password: string;
  birthday: string;
  gender: string;
  address: string;
}

const RegisterManagement = () => {
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createregister").then((res) => {
      console.log("---new data---", res.data);
      
      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          id: item.id,
          key: item.id,
          username: item.username,
          lastname: item.lastname,
          email: item.email,
          password: item.password,
          birthday: item.birthday,
          gender: item.gender,
          address: item.address,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getallregisteredusers").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        id: item.id,
        key: item.id,
        username: item.username,
        lastname: item.lastname,
        email: item.email,
        password: item.password,
        birthday: item.birthday,
        gender: item.gender,
        address: item.address
      }));
      setData(updatedData);
    });
  }, []);

  const handleChange = (item: string, key: number, value: any) => {
    if (data) {
      const temp: DType[] = [];
      let element;
      for (let i = 0; i < data?.length; i++) {
        if (data[i]?.key === key) {
          element = {
            ...data[i],
            [item]: value,
          };
        } else
          element = {
            ...data[i],
          };
        temp.push(element);
      }
      setData(temp);
    }
  };

  const handleDeleteClick = (id: number) => {
    setIsOpenRemove(true);
    setRemoveId(id);
  };

  const handleUpdateClick = (id: number) => {
    setUpdateId(id);
    if (data) {
      for (let i = 0; i < data?.length; i++) {
        if (id === data[i].key) setUpdatedData(data[i]);
      }
    }
    setIsOpenUpdate(true);
  };

  const myColumns: TableProps<DType>["columns"] = [
    {
      title: "ID",
      dataIndex: "id",
      key: "id",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.id}
            onChange={(e) =>
              handleChange("id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Username",
      dataIndex: "username",
      key: "username",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.username}
            onChange={(e) =>
              handleChange("username", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Lastname",
      dataIndex: "lastname",
      key: "lastname",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.lastname}
            onChange={(e) =>
              handleChange("lastname", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "E-mail",
      dataIndex: "email",
      key: "email",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.email}
            onChange={(e) => handleChange("email", record.key, e.target.value)}
          ></input>
        </>
      ),
    },

    {
      title: "Password",
      dataIndex: "password",
      key: "password",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.password}
            onChange={(e) =>
              handleChange("password", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Birthday",
      dataIndex: "birthday",
      key: "birthday",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.birthday}
            onChange={(e) =>
              handleChange("birthday", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Gender",
      dataIndex: "gender",
      key: "gender",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.gender}
            onChange={(e) => handleChange("gender", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Address",
      dataIndex: "address",
      key: "address",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.address}
            onChange={(e) =>
              handleChange("address", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Update Register",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Register",
      dataIndex: "delete",
      key: "delete",
      render: (_, record) => (
        <>
          <Button
            type="primary"
            danger
            onClick={() => handleDeleteClick(record.key)}
          >
            Remove
          </Button>
        </>
      ),
    },
  ];

  return (
    <div className="mx-5 h-[550px] w-full">
      <div className="flex flex-col pt-10">
        <div className="mb-5 w-full" >
          <button
            className="h-[30px]  rounded-md bg-success text-lg text-white w-[100px]"
            onClick={handAddClick}
          >
            Add New
          </button>
        </div>
      </div>
      <div className="mt-10 h-[450px] w-[1580px] overflow-scroll">
        <Table
          columns={myColumns}
          dataSource={data}          
        />
      </div>
      <RemoveModal
        removeId={removeId}
        isOpenRemove={isOpenRemove}
        setIsOpenRemove={setIsOpenRemove}
        setData={setData}
      />
      {data && (
        <UpdateModal
          updateId={updateId}
          isOpenUpdate={isOpenUpdate}
          setIsOpenUpdate={setIsOpenUpdate}
          updatedData={updatedData}
          setData={setData}
        />
      )}
    </div>
  );
};

export default RegisterManagement;
