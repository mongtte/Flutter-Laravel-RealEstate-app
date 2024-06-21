import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
import RemoveModal from "./RemoveModal";
import UpdateModal from "./UpdateModal";

interface DType {
  key: number;
  id: number;
  language: string;
  slug: string;
  name_en: string;
  name_es: string;
  name_it: string;
  color: string;
  icon: string;
  type: string;
}

const CategoryManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createcategory").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          language: item.language,
          slug: item.slug,
          name_en: item.name_en,
          name_es: item.name_es,
          name_it: item.name_it,
          color: item.color,
          icon: item.icon,
          type: item.type,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getcategory").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        language: item.language,
        slug: item.slug,
        name_en: item.name_en,
        name_es: item.name_es,
        name_it: item.name_it,
        color: item.color,
        icon: item.icon,
        type: item.type,
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
      title: "Language",
      dataIndex: "language",
      key: "language",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.language}
            onChange={(e) =>
              handleChange("language", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Slug",
      dataIndex: "slug",
      key: "slug",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.slug}
            onChange={(e) => handleChange("slug", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Name_en",
      dataIndex: "name_en",
      key: "name_en",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.name_en}
            onChange={(e) =>
              handleChange("name_en", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Name_en",
      dataIndex: "name_es",
      key: "name_es",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.name_es}
            onChange={(e) =>
              handleChange("name_es", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Name_it",
      dataIndex: "name_it",
      key: "name_it",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.name_it}
            onChange={(e) =>
              handleChange("name_it", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Color",
      dataIndex: "color",
      key: "color",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.color}
            onChange={(e) => handleChange("color", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Icon",
      dataIndex: "icon",
      key: "icon",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.icon}
            onChange={(e) => handleChange("icon", record.key, e.target.value)}
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
      title: "Update Category",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Category",
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

export default CategoryManagement;
