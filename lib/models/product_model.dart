import 'package:flutter/cupertino.dart';

class ProductModel {
  @required
  String pName;
  @required
  String pPrice;
  @required
  String pLocation;
  @required
  String pDescription;
  @required
  String pCategory;
  @required
  String pId;

  ProductModel(
      {this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pName,
      this.pPrice,
      this.pId});
}
