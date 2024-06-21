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
  message: string;
  type: string;
  user_id: string;
  room_id: string;
}

const MessagesManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createchats").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id : item.id,
          message: item.message,
          type: item.type,
          user_id: item.user_id,
          room_id: item.room_id,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getallchats").then((res) => {
      // console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id : item.id,
        message: item.message,
        type: item.type,
        user_id: item.user_id,
        room_id: item.room_id,
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
      title: "Message",
      dataIndex: "message",
      key: "message",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.message}
            onChange={(e) =>
              handleChange("message", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Type",
      dataIndex: "type",
      key: "type",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.type}
            onChange={(e) => handleChange("type", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "UserID",
      dataIndex: "user_id",
      key: "user_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.user_id}
            onChange={(e) =>
              handleChange("user_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "RoomID",
      dataIndex: "room_id",
      key: "room_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.room_id}
            onChange={(e) =>
              handleChange("room_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },

    {
      title: "Update Messages",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Messages",
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

export default MessagesManagement;
