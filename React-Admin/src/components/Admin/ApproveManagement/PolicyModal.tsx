import { Modal, Button } from "antd";
import { TextField } from "@mui/material";
import { myAxios } from "@/redux/actions/Constants";
import { useState } from "react";
import toastr from "toastr";

type Props = {
  policyModal: boolean;
  setPolicyModal: any;
};

const PolicyModal = ({ policyModal, setPolicyModal }: Props) => {
  const onClose = () => {
    setPolicyModal(false);
  };
  const [description, setDescription] = useState<string>("");
  const [language, setLanguage] = useState<string>("English");

  const onhandleLanguage = (lang: string) => {
    setLanguage(lang);
    setDescription("");
  };

  const onhandleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setDescription(event.target.value);
  };

  const setPolicy = async () => {
    try {
      const res = await myAxios.post("/admin/setpolicy", {
        description: description,
        language: language,
      });
      console.log("---updatedData---", res.data);
      if (res.data == "success") {
        toastr.success("Policy updated successfully");
      } else {
        toastr.error(res.data);
      }
    } catch (error) {
      toastr.error("Server Error");
      console.log(error);
    }
  };

  const onUpdate = () => {
    setPolicy();
  };

  return (
    <Modal
      open={policyModal}
      centered={true}
      onCancel={onClose}
      width="fit-content"
      footer={false}
    >
      <div className="mx-0 mt-10">
        <div
          style={{
            display: "flex",
            justifyContent: "space-around",
            alignItems: "center",
            gap: 10,
            marginBottom: "10px",
          }}
        >
          <Button
            type="primary"
            danger
            style={{ backgroundColor: "red" }}
            onClick={() => onhandleLanguage("English")}
          >
            English
          </Button>
          <Button
            type="primary"
            danger
            style={{ backgroundColor: "brown" }}
            onClick={() => onhandleLanguage("Spanish")}
          >
            Spanish
          </Button>
          <Button
            type="primary"
            danger
            style={{ backgroundColor: "green" }}
            onClick={() => onhandleLanguage("Italian")}
          >
            Italian
          </Button>
        </div>
        <div
          className="flex justify-end"
          style={{
            borderTop: "solid 1px lightgray",
            paddingTop: "10px",
            gap: "10px",
            marginBottom: "10px",
          }}
        >
          <Button
            type="primary"
            danger
            style={{ backgroundColor: "green" }}
            onClick={onUpdate}
          >
            Update
          </Button>
        </div>
        <div>
          <TextField
            id="outlined-multiline-flexible"
            label="Description"
            value={description}
            onChange={onhandleChange}
            multiline
            rows={10}
            maxRows={15}
            sx={{ width: "400px" }}
          />
        </div>
      </div>
    </Modal>
  );
};

export default PolicyModal;
