import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
// import RemoveModal from "./RemoveModal";
import UpdateModal from "./UpdateModal";

interface DType {
  key: number;
  id: number;
  aday: number;
  oneweek: number;
  onemonth: number;
  twomonths: number;
}

const PaymentManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  // const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  // const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  useEffect(() => {
    myAxios.get("admin/price").then((res) => {
      // console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        aday: item.aday_price,
        oneweek: item.oneweek_price,
        onemonth: item.onemonth_price,
        twomonths: item.twomonths_price
      }));
      setData(updatedData);
    });
  }, [])

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
      title: "A day payment",
      dataIndex: "aday",
      key: "aday",
      render: (_, record) => (
        <>
          <input
            type="aday"
            defaultValue={record.aday}
            onChange={(e) =>
              handleChange("aday", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    
    {
      title: "One week payment",
      dataIndex: "oneweek",
      key: "oneweek",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.oneweek}
            onChange={(e) => handleChange("oneweek", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "One month payment",
      dataIndex: "onemonth",
      key: "onemonth",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.onemonth}
            onChange={(e) => handleChange("onemonth", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Two months payment",
      dataIndex: "twomonths",
      key: "twomonths",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.twomonths}
            onChange={(e) => handleChange("twomonths", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Update Price",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)} type="primary" color="success">Update</Button>
        </>
      ),
    },
  ];

  return (
    <div className="mx-5 h-[550px] w-full">
      <div className="flex flex-col pt-10">
      </div>
      <div className="mt-10 h-[450px] w-[1580px] overflow-scroll">
        <Table
          columns={myColumns}
          dataSource={data}          
        />
      </div>
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

export default PaymentManagement;
