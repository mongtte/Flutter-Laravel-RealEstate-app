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
      .post("/admin/updatemultimedia", {
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
            url: item.url,
            previewUrl: item.previewUrl,
            good_id: item.good_id,
          }));
          setData(updatedData);
          toastr.success("Multimedia updated successfully");
        }
      }).catch(() => {
        toastr.error("Server Error");
      })
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
            Are you sure you wish to update this multimedia?
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
