import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/modules/admin/add_product_screen.dart';
import 'package:e_commerce_app/modules/admin/manage_product_screen.dart';
import 'package:e_commerce_app/modules/admin/order_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customButton(
                text: 'Add Product',
                function: () {
                  navigateTo(context: context, widget: AddProductScreen());
                }),
            customButton(
                text: 'Edit Product',
                function: () {
                  navigateTo(context: context, widget: ManageProduct());
                }),
            customButton(
                text: 'View orders',
                function: () {
                  navigateTo(context: context, widget: OrderScreen());
                }),
          ],
        ),
      ),
    );
  }
}
