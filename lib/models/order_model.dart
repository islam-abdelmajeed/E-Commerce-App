import 'package:flutter/cupertino.dart';

class OrderModel {
 @required int totalPrice;
 @required String address;
 String documentId;

  OrderModel({this.address, this.totalPrice, this.documentId});
}
