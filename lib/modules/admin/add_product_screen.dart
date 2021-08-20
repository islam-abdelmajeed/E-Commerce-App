import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  String name, price, description, category, imageLocation;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final store = Store();
  @override
  Widget build(BuildContext context) {
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
                text: 'Add Product',
                function: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    store.addProduct(ProductModel(
                      pName: name,
                      pPrice: price,
                      pDescription: description,
                      pCategory: category,
                      pLocation: imageLocation,
                    ));
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
