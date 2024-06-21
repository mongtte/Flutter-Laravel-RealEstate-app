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
  user_id: number;
  product_id: number;
  startDate: any;
  endDate: any;
  servicekind: string;
  availableDays: number;
}

const ServiceManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/plusservices").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          user_id: item.user_id,
          product_id: item.product_id,
          startDate: item.startDate,
          endDate: item.endDate,
          servicekind: item.servicekind,
          availableDays: item.availableDays,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/sendallservices").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        user_id: item.user_id,
        product_id: item.product_id,
        startDate: item.startDate,
        endDate: item.endDate,
        servicekind: item.servicekind,
        availableDays: item.availableDays,
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
      title: "User ID",
      dataIndex: "user_id",
      key: "user_id",
      render: (_, record) => (
        <>
          <input
            type="user_id"
            defaultValue={record.user_id}
            onChange={(e) => handleChange("user_id", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Product ID",
      dataIndex: "product_id",
      key: "product_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.product_id}
            onChange={(e) =>
              handleChange("product_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Start Date",
      dataIndex: "startDate",
      key: "startDate",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.startDate}
            onChange={(e) =>
              handleChange("startDate", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "End Date",
      dataIndex: "endDate",
      key: "endDate",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.endDate}
            onChange={(e) =>
              handleChange("endDate", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Service Kind",
      dataIndex: "servicekind",
      key: "servicekind",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.servicekind}
            onChange={(e) => handleChange("servicekind", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Available Days",
      dataIndex: "availableDays",
      key: "availableDays",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.availableDays}
            onChange={(e) => handleChange("availableDays", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Update Service",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)} type="primary" color="success">Update</Button>
        </>
      ),
    },
    {
      title: "Remove Service",
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

export default ServiceManagement;
