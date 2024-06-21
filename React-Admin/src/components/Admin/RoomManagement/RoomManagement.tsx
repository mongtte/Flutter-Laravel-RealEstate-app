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
  product_id: string;
  seller_user_id: string;
  buyer_user_id: string;
}

const RoomManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  useEffect(() => {
    myAxios.get("/admin/getallroom").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        product_id: item.product_id,
        seller_user_id: item.seller_user_id,
        buyer_user_id: item.buyer_user_id,
      }));
      setData(updatedData);
    });
  }, []);

  const handAddClick = async () => {
    await myAxios.post("/admin/createroom").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          product_id: item.product_id,
          seller_user_id: item.seller_user_id,
          buyer_user_id: item.buyer_user_id,
        }));
        setData(updatedData);
      }
    });
  };

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
            onChange={(e) => handleChange("id", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "ProductID",
      dataIndex: "product_id",
      key: "product_id",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.product_id}
            onChange={(e) =>
              handleChange("product_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },

    {
      title: "SellerUserID",
      dataIndex: "seller_user_id",
      key: "seller_user_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.seller_user_id}
            onChange={(e) =>
              handleChange("seller_user_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "BuyerUserID",
      dataIndex: "buyer_user_id",
      key: "buyer_user_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.buyer_user_id}
            onChange={(e) =>
              handleChange("buyer_user_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },

    {
      title: "Update Rooms",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Rooms",
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

export default RoomManagement;
