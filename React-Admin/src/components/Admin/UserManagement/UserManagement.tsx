import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
import RemoveModal from "./RemoveModal";
import UpdateModal from "./UpdateModal";
import "../../style.css";

interface DType {
  key: number;
  id: number;
  username: string;
  email: string;
  birthday: string;
  nameLastname: string;
  currentLocation: string;
}

const UserManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createusers").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          id: item.id,
          key: item.id,
          username: item.username,
          email: item.email,
          birthday: item.birthday,
          nameLastname: item.nameLastname,
          currentLocation: item.currentLocation,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getallusers").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        id: item.id,
        key: item.id,
        username: item.username,
        email: item.email,
        birthday: item.birthday,
        nameLastname: item.nameLastname,
        currentLocation: item.currentLocation,
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
            type="id"
            defaultValue={record.id}
            onChange={(e) => handleChange("id", record.key, e.target.value)}
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
      title: "Lastname",
      dataIndex: "nameLastname",
      key: "nameLastname",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.nameLastname}
            onChange={(e) =>
              handleChange("nameLastname", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Current Location",
      dataIndex: "currentLocation",
      key: "currentLocation",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.currentLocation}
            onChange={(e) =>
              handleChange("currentLocation", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Update User",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove User",
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
        <div className="mb-5 w-full">
          <button
            className="h-[30px]  w-[100px] rounded-md bg-success text-lg text-white"
            onClick={handAddClick}
          >
            Add New
          </button>
        </div>
      </div>
      <div className="mt-10 h-[450px] w-[1580px] overflow-scroll">
        <Table columns={myColumns} dataSource={data} />
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

export default UserManagement;
