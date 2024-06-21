import { Modal } from "antd";
type props = {
  isShowModal: boolean;
  setIsShowModal: any;
  imageURL: any;
};
const ShowModal = ({
  isShowModal,
  setIsShowModal,
  imageURL,
}: //
props) => {
  const onClose = () => {
    setIsShowModal(false);
  };
  console.log("modal imageURL", imageURL);
  return (
      <Modal
        open={isShowModal}
        centered={true}
        onCancel={onClose}
        width="fit-content"
        footer={false}
      >
        <div className="mx-0 mt-10">
          <div className="mb-10 text-xl" style={{display: "flex", justifyContent: "center", alignItems: "center"}}>
            {Array.isArray(imageURL) ? (
              imageURL.map((item, index) => {
                return <div style={{border: "solid 1px red", margin: "5px"}}><img key={index} src={item} alt="image"/></div>;
              })
            ) : (
                    <div style={{border: "solid 1px rgb(0,170,255)", margin: "5px"}}><img src={imageURL} alt="image" style={{ width: "300px" }} /></div>
            )}
          </div>
          {/* <div className="flex justify-end" style={{borderTop: "solid 1px lightgray", paddingTop: "10px"}}>
            <Button type="primary" danger>Approve</Button>
          </div> */}
        </div>
      </Modal>
  );
};

export default ShowModal;

