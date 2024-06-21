import { Modal, Button } from "antd";
import { myAxios } from "@/redux/actions/Constants";
import toastr from "toastr"

type props = {
  removeId:number,
  isOpenRemove: boolean,
  setIsOpenRemove: any,
  setData:any,
}

const RemoveModal = ({removeId, isOpenRemove, setIsOpenRemove, setData}:props) => {

  const onClose = () => {
    setIsOpenRemove(false);
  }

  const handleRemove = async () => {
    setIsOpenRemove(false);
    // console.log(removeId);
    await myAxios.post("/admin/deleteregister", { id: removeId }).then((res) => {
      console.log(res.data);
      if(res.data) {
        const updatedData = res.data.map((item: any, index: any) => ({
          index: index + 1,
          id: item.id,
          key: item.id,
          username: item.username,
          lastname: item.lastname,
          email: item.email,
          password: item.password,
          birthday: item.birthday,
          gender: item.gender,
          address: item.address
        }));
        setData(updatedData);
        toastr.success("User removed successfully");
      }
    }).catch(() => {
      toastr.error("Server Error");
    })
  }

  return (
    <>
      <Modal
        open={isOpenRemove}
        centered={true}
        onCancel={onClose}
        width={500}
        footer={false}
      >
        <div className="my-10 mx-5">
          <div className="mb-10 text-xl">
            Are you sure you wish to remove this user?
          </div>
          <div className="flex justify-end">
            <Button type="primary" danger onClick={handleRemove} >Remove</Button>
          </div>
        </div>
      </Modal>
    </>
  )
}

export default RemoveModal;