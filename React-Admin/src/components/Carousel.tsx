import React from "react";
import Carousel from "react-material-ui-carousel";
import { Paper, Button } from "@mui/material";
// import {
//   getProducts,
//   setAddProductAlert,
// } from "@/redux/reducers/ProductStatus";
import { useSelector } from "@/redux/store";
// import { useDispatch } from "@/redux/store";
import Badge, { BadgeProps } from "@mui/material/Badge";
import { styled } from "@mui/material/styles";
import IconButton from "@mui/material/IconButton";
import ShoppingCartIcon from "@mui/icons-material/ShoppingCart";
// import aImage from './assets/a.jpg'; // Import image
const StyledBadge = styled(Badge)<BadgeProps>(({ theme }) => ({
  "& .MuiBadge-badge": {
    right: -3,
    top: 13,
    border: `2px solid ${theme.palette.background.paper}`,
    padding: "0 4px",
  },
}));

interface ItemProps {
  name: string;
  description: string;
  imageUrl: string; // New property for image URL
}

const Carousell: React.FC = () => {
  const items: ItemProps[] = [
    {
      name: "Aya Bouchiha",
      description: "Full Stack Web Developer",
      imageUrl: "./src/assets/a.jpg", // Use imported image
    },
    {
      name: "John Doe",
      description: "Author",
      imageUrl: "./src/assets/b.jpg", // Use imported image
    },
    {
      name: "Pitsu Coma",
      description: "Math Student",
      imageUrl: "./src/assets/c.jpg", // Use imported image
    },
  ];
  // const [productsStatus, setProductsStatus] = React.useState<any>();
  // const [productsCount, setProductsCount] = React.useState<number>(0);
  // const products = useSelector((state) => state.products.products);
  // const dispatch = useDispatch();

  // React.useEffect(() => {
  //   dispatch(getProducts());
  // });
  // React.useEffect(() => {
  //   setProductsStatus(products);
  //   setProductsCount(products.length);
  // }, [products, setProductsStatus]);

  // console.log(
  //   "Products Status---------------->",
  //   productsStatus,
  //   productsCount,
  // );
  return (
    <Carousel sx={{ height: "250px" }}>
      {items.map((item, i) => (
        <Item key={i} {...item} />
      ))}
      
    </Carousel>
  );
};

const Item: React.FC<ItemProps> = ({ name, description, imageUrl }) => {
  const [productsCount, setProductsCount] = React.useState<number>(0);
  const products = useSelector((state) => state.products.products);
  React.useEffect(() => {
    setProductsCount(products.length);
  }, [products, setProductsCount]);

  return (
    <Paper sx={{ height: "250px", borderBottom: "solid 1px lightgray" }}>
      <img
        src={imageUrl}
        alt={name}
        style={{ width: "100%", height: "250px", objectFit: "cover" }}
      />{" "}
      <h2>{name}</h2>
      <p>{description}</p>
      <Button>more info...</Button>
      <IconButton aria-label="cart" sx= {{position: "absolute", right: "50px", top: "10px"}}>
        <StyledBadge badgeContent={productsCount} color="secondary">
          <ShoppingCartIcon sx={{color: "red"}}/>
        </StyledBadge>
      </IconButton>
    </Paper>
  );
};

export default Carousell;
