import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
import { IconButton } from "@mui/material";
import RemoveRedEyeIcon from "@mui/icons-material/RemoveRedEye";
import RemoveModal from "./RemoveModal";
import UpdateModal from "./UpdateModal";
import ShowModal from "./ShowModal";
import "../../style.css";

interface DType {
  key: number;
  id: number;
  url: string;
  previewUrl: string;
  good_id: string;
}

const MultimediaManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createmultimedia").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          url: item.url,
          previewUrl: item.previewUrl,
          good_id: item.good_id,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getmultimedia").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        url: item.url,
        previewUrl: item.previewUrl,
        good_id: item.good_id,
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
  const [showModal, setShowModal] = useState(false);
  const [imageURL, setImageURL] = useState<string>();

  const myColumns: TableProps<DType>["columns"] = [
    {
      title:"ID",
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
      title: "URL",
      dataIndex: "url",
      key: "url",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.url}
            onChange={(e) => handleChange("url", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "PreviewURL",
      dataIndex: "previewUrl",
      key: "previewUrl",
      render: (_, record) => (
        <>
          {/* <input
            defaultValue={record.previewUrl}
            onChange={(e) =>
              handleChange("previewUrl", record.key, e.target.value)
            }
          ></input> */}
          <IconButton  onClick={() => {setShowModal(true); setImageURL(record.url)}}>
            <RemoveRedEyeIcon />
          </IconButton>
        </>
      ),
    },
    {
      title: "Product ID",
      dataIndex: "good_id",
      key: "good_id",
      render: (_, record) => (
        <>
          <input
            type="good_id"
            defaultValue={record.good_id}
            onChange={(e) =>
              handleChange("good_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Update Multimedia",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Multimedia",
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
      <ShowModal isShowModal={showModal} setIsShowModal={setShowModal} imageURL={imageURL} />
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

export default MultimediaManagement;
