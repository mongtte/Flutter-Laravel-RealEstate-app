import { Modal, Button } from "antd";
import { myAxios } from "@/redux/actions/Constants";
import toastr from "toastr";

type props = {
  removeId: number;
  isOpenRemove: boolean;
  setIsOpenRemove: any;
  setData: any;
};

const RemoveModal = ({
  removeId,
  isOpenRemove,
  setIsOpenRemove,
  setData,
}: props) => {
  const onClose = () => {
    setIsOpenRemove(false);
  };

  const handleRemove = async () => {
    setIsOpenRemove(false);
    // console.log(removeId);
    await myAxios
      .post("/admin/deletelikes", { id: removeId })
      .then((res) => {
        console.log(res.data);
        if (res.data) {
          const updatedData = res.data.map((item: any, index: any) => ({
            index: index + 1,
            key: item.id,
            id : item.id,
            user: item.user,
            product: item.product,
            good_id: item.good_id,
          }));
          setData(updatedData);
          toastr.success("Like removed successfully");
        }
      })
      .catch(() => {
        toastr.error("Server Error");
      });
  };

  return (
    <>
      <Modal
        open={isOpenRemove}
        centered={true}
        onCancel={onClose}
        width={500}
        footer={false}
      >
        <div className="mx-5 my-10">
          <div className="mb-10 text-xl">
            Are you sure you wish to remove this like?
          </div>
          <div className="flex justify-end">
            <Button type="primary" danger onClick={handleRemove}>
              Remove
            </Button>
          </div>
        </div>
      </Modal>
    </>
  );
};

export default RemoveModal;
