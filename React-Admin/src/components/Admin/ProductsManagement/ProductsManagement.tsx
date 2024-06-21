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
  title: string;
  description: string;
  category: string;
  country: string;
  city: string;
  price: string;
  currency: string;
  phone_number: string;
  status: string;
  status_product: string;
  people_type: string;
  ad_type: string;
  sub_category_id: number;
  user_id: number;
}

const ProductsManagement = () => {
  // const [changeStatus, setChangeStatus] = useState<boolean>(false);
  const [isOpenRemove, setIsOpenRemove] = useState<boolean>(false);
  const [isOpenUpdate, setIsOpenUpdate] = useState<boolean>(false);
  const [removeId, setRemoveId] = useState<number>(-1);
  const [updateId, setUpdateId] = useState<number>(-1);
  const [updatedData, setUpdatedData] = useState<DType>();
  const [data, setData] = useState<DType[]>();

  const handAddClick = async () => {
    await myAxios.post("/admin/createproducts").then((res) => {
      console.log("---new data---", res.data);

      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.id,
          id: item.id,
          title: item.title,
          description: item.description,
          category: item.category,
          country: item.country,
          city: item.city,
          price: item.price,
          currency: item.currency,
          phone_number: item.phone_number,
          status: item.status,
          status_product: item.status_product,
          people_type: item.people_type,
          ad_type: item.ad_type,
          sub_category_id: item.sub_category_id,
          user_id: item.user_id,
        }));
        setData(updatedData);
      }
    });
  };

  useEffect(() => {
    myAxios.get("/admin/getallproducts").then((res) => {
      console.log(res.data);
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.id,
        id: item.id,
        title: item.title,
        description: item.description,
        category: item.category,
        country: item.country,
        city: item.city,
        price: item.price,
        currency: item.currency,
        phone_number: item.phone_number,
        status: item.status,
        status_product: item.status_product,
        people_type: item.people_type,
        ad_type: item.ad_type,
        sub_category_id: item.sub_category_id,
        user_id: item.user_id,
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
      title: "Title",
      dataIndex: "title",
      key: "title",
      render: (_, record) => (
        <>
          <input
            type="text"
            defaultValue={record.title}
            onChange={(e) => handleChange("title", record.key, e.target.value)}
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
      title: "Category",
      dataIndex: "category",
      key: "category",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.category}
            onChange={(e) =>
              handleChange("category", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Country",
      dataIndex: "country",
      key: "country",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.country}
            onChange={(e) =>
              handleChange("country", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "City",
      dataIndex: "city",
      key: "city",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.city}
            onChange={(e) => handleChange("city", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Price",
      dataIndex: "price",
      key: "price",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.price}
            onChange={(e) => handleChange("price", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Currency",
      dataIndex: "currency",
      key: "currency",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.currency}
            onChange={(e) =>
              handleChange("currency", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Phone Number",
      dataIndex: "phone_number",
      key: "phone_number",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.phone_number}
            onChange={(e) =>
              handleChange("phone_number", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Status",
      dataIndex: "status",
      key: "status",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.status}
            onChange={(e) => handleChange("status", record.key, e.target.value)}
          ></input>
        </>
      ),
    },
    {
      title: "Status Product",
      dataIndex: "status_product",
      key: "status_product",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.status_product}
            onChange={(e) =>
              handleChange("status_product", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "People Type",
      dataIndex: "people_type",
      key: "people_type",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.people_type}
            onChange={(e) =>
              handleChange("people_type", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Ad Type",
      dataIndex: "ad_type",
      key: "ad_type",
      render: (_, record) => (
        <>
          <input
            defaultValue={record.ad_type}
            onChange={(e) =>
              handleChange("ad_type", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Subcategory Id",
      dataIndex: "sub_category_id",
      key: "sub_category_id",
      render: (_, record) => (
        <>
          <input
            type="number"
            defaultValue={record.sub_category_id}
            onChange={(e) =>
              handleChange("sub_category_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "User Id",
      dataIndex: "user_id",
      key: "user_id",
      render: (_, record) => (
        <>
          <input
            type="number"
            defaultValue={record.user_id}
            onChange={(e) =>
              handleChange("user_id", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Update Product",
      dataIndex: "update",
      key: "update",
      render: (_, record) => (
        <>
          <Button onClick={() => handleUpdateClick(record.key)}>Update</Button>
        </>
      ),
    },
    {
      title: "Remove Product",
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

export default ProductsManagement;
