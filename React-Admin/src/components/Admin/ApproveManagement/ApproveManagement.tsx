import { Button, Table } from "antd";
import type { TableProps } from "antd";
import { useEffect, useState } from "react";
import { myAxios } from "@/redux/actions/Constants";
import { IconButton } from "@mui/material";
import RemoveRedEyeIcon from "@mui/icons-material/RemoveRedEye";
import toastr from "toastr";
import ShowModal from "./ShowModal";
import PolicyModal from "./PolicyModal";
import { getApprovedProducts } from "@/redux/reducers/ProductStatus";
import { useDispatch } from "@/redux/store";
interface DType {
  // index: number;
  key: number;
  id: number;
  user_id: number;
  product_id: number;
  title: string;
  description: string;
  imageUrl: string[];
}

const ApproveManagement = () => {
  const [data, setData] = useState<DType[]>();
  // const [productsStatus, setProductsStatus] = useState<any>();
  // const products = useSelector((state) => state.products.products);
  const dispatch  = useDispatch();

  const [policyModal, setPolicyModal] = useState(false);
  const handlePolicy = () => {
    setPolicyModal(true);
  }

  useEffect(() => {
    myAxios.get("/admin/approve").then((res) => {
      const updatedData = res.data.map((item: any, index: any) => ({
        index: index + 1,
        key: item.product_id,
        id: index + 1,
        user_id: item.user_id,
        product_id: item.product_id,
        title: item.title,
        description: item.description,
        imageUrl: item.imageUrl,
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

  const setApproved = async (product_id: number) => {
    try {
      const res = await myAxios.post("/admin/approve", {
        id: product_id,
      });
      console.log("---updatedData---", res.data);
      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.product_id,
          id: index + 1,
          user_id: item.user_id,
          product_id: item.product_id,
          title: item.title,
          description: item.description,
          imageUrl: item.imageUrl,
        }));
        setData(updatedData);
        toastr.success("Approved successfully");
      }
      dispatch(getApprovedProducts(product_id));
    } catch (error) {
      toastr.error("Server Error");
    }
  };

  const setCancled = async (product_id: number) => {
    try {
      const res = await myAxios.post("/admin/cancle", {
        id: product_id,
      });
      console.log("---updatedData---", res.data);
      if (res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          key: item.product_id,
          id: index + 1,
          user_id: item.user_id,
          product_id: item.product_id,
          title: item.title,
          description: item.description,
          imageUrl: item.imageUrl,
        }));
        setData(updatedData);
        toastr.success("Cancled successfully");
      }
    } catch (error) {
      toastr.error("Server Error");
    }
  };

  const [showModal, setShowModal] = useState(false);
  const [imageURL, setImageURL] = useState<string[]>([]);
  const [productID, setProductID] = useState<number>(0);
  // console.log("---->imageURL", imageURL);

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
      title: "UserID",
      dataIndex: "user_id",
      key: "user_id",
      render: (_, record) => (
        <>
          <input
            type="user_id"
            defaultValue={record.user_id}
            onChange={(e) =>
              handleChange("user_id", record.key, e.target.value)
            }
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
            type="product_id"
            defaultValue={record.product_id}
            onChange={(e) =>
              handleChange("product_id", record.key, e.target.value)
            }
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
            type="title"
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
            type="description"
            defaultValue={record.description}
            onChange={(e) =>
              handleChange("description", record.key, e.target.value)
            }
          ></input>
        </>
      ),
    },
    {
      title: "Imgage",
      dataIndex: "imageUrl",
      key: "imageUrl",
      render: (_, record) => (
        <>
          <IconButton
            onClick={() => {
              setShowModal(true);
              setImageURL(record.imageUrl);
              setProductID(record.product_id);
            }}
          >
            <RemoveRedEyeIcon />
          </IconButton>
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
            onClick={handlePolicy}
          >
            Policy
          </button>
        </div>
      </div>
      <div className="mt-10 h-[450px] w-[1580px] overflow-scroll">
        <Table columns={myColumns} dataSource={data} />
      </div>
      <ShowModal
        isShowModal={showModal}
        setIsShowModal={setShowModal}
        imageURL={imageURL}
        handleApprove={() => setApproved(productID)}
        handleCancle={() => setCancled(productID)}
        product_id={productID}
      />
      <PolicyModal policyModal={policyModal} setPolicyModal={setPolicyModal}/>
    </div>
  );
};

export default ApproveManagement;
