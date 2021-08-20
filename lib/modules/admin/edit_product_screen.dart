import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static String id = 'EditProduct';
  String name, price, description, category, imageLocation;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final store = Store();

  @override
  Widget build(BuildContext context) {
    ProductModel products = ModalRoute.of(context).settings.arguments;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              customTextField(
                  hint: 'Product Name',
                  onClick: (value) {
                    name = value;
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              customTextField(
                  hint: 'Product Price',
                  onClick: (value) {
                    price = value;
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              customTextField(
                  hint: 'Product Description',
                  onClick: (value) {
                    description = value;
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              customTextField(
                  hint: 'Product Category',
                  onClick: (value) {
                    category = value;
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              customTextField(
                  hint: 'Product Location',
                  onClick: (value) {
                    imageLocation = value;
                  }),
              SizedBox(
                height: height * 0.04,
              ),
              customButton(
                text: 'Edit Product',
                function: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    store.editProduct({
                      kProductName: name,
                      kProductPrice: price,
                      kProductDescription: description,
                      kProductLocation: imageLocation,
                      kProductCategory: category,
                    }, products.pId);
                  }
                },
                color: kMainColor,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
