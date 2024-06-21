import { Modal, Button } from "antd";
import { myAxios } from "@/redux/actions/Constants";
import toastr from "toastr";
type props = {
  updateId: number;
  isOpenUpdate: boolean;
  setIsOpenUpdate: any;
  updatedData: any;
  setData: any;
};

const UpdateModal = ({
  updateId,
  isOpenUpdate,
  setIsOpenUpdate,
  updatedData,
  setData,
}: //
props) => {
  const handleUpdate = async () => {
    setIsOpenUpdate(false);
    console.log(updateId);
    console.log(updatedData);

    await myAxios
      .post("/admin/updatecategory", {
        id: updateId,
        updatedData: updatedData,
      })
      .then((res) => {
        console.log("---updatedData---", res.data);
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
          toastr.success("Category updated successfully");
        }
      })
      .catch(() => {
        toastr.error("Server Error");
      });
  };

  const onClose = () => {
    setIsOpenUpdate(false);
  };

  return (
    <>
      <Modal
        open={isOpenUpdate}
        centered={true}
        onCancel={onClose}
        width={500}
        footer={false}
      >
        <div className="mx-5 my-10">
          <div className="mb-10 text-xl">
            Are you sure you wish to update this Category?
          </div>
          <div className="flex justify-end">
            <Button onClick={handleUpdate}>Update</Button>
          </div>
        </div>
      </Modal>
    </>
  );
};

export default UpdateModal;
