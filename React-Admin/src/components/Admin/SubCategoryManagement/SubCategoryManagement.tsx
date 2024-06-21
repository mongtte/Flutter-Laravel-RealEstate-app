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
  nameSubCategory: string;
  description: string;
  language: string;
  published_at: string;
  name_en: string;
  name_es: string;
  name_it: string;
  category_id: string;
}

const SubCategoryManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createsubcategory").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          nameSubCategory: item.nameSubCategory,
          description: item.description,
          language: item.language,
          name_en: item.name_en,
          name_es: item.name_es,
          name_it: item.name_it,
          published_at: item.published_at,
          category_id: item.category_id,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getallsubcategory").then((res) => {
      // console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        nameSubCategory: item.nameSubCategory,
        description: item.description,
        language: item.language,
        name_en: item.name_en,
        name_es: item.name_es,
        name_it: item.name_it,
        published_at: item.published_at,
        category_id: item.category_id,
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
            onChange={(e) => handleChange("id", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "NameSubCategory",
      dataIndex: "nameSubCategory",
      key: "nameSubCategory",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.nameSubCategory}
            onChange={(e) =>
              handleChange("nameSubCategory", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Description",
      dataIndex: "description",
      key: "description",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.description}
            onChange={(e) =>
              handleChange("description", record.key, e.target.value)
            }
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
            defaultValue={record.language}
            onChange={(e) =>
              handleChange("language", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Published_at",
      dataIndex: "published_at",
      key: "published_at",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.published_at}
            onChange={(e) =>
              handleChange("published_at", record.key, e.target.value)
            }
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
      title: "Name_es",
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
      title: "Category_id",
      dataIndex: "category_id",
      key: "category_id",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.category_id}
            onChange={(e) =>
              handleChange("category_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },

    {
      title: "Update SubCategory",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove SubCategory",
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

export default SubCategoryManagement;
