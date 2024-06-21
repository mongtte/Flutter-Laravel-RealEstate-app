import 'package:hero/models/products/products.dart';
import 'package:hero/shared/catalogs/list_enums.dart';

class PublishAdModel {
  PublishAdModel({
    required this.currentCategory,
    required this.currenTypeAd,
    required this.currentSubCategory,
  });

  EnumCategoryList currentCategory;
  EnumTypeAdList currenTypeAd;
  EnumSubCategoryList currentSubCategory;
  Products? product;
}
