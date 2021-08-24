import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  static String id = 'orderDetails';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String documentId = ModalRoute.of(context).settings.arguments;
    Store store = Store();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrderDetails(documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> product=[];
            for(var doc in snapshot.data.docs){
              product.add(ProductModel(

                pName: doc[kProductName],
                count: doc[kCount],
                pCategory: doc[kProductCategory],
              ));
            }
            return ListView.builder(
              itemCount: product.length,
              itemBuilder:(context , index)=> Container(
                height: height * 0.2,
                color: kSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product name : ${product[index].pName}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Count : ${product[index].count}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Product Category : ${product[index].pCategory}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
                child: Text(
              'Loading ...',
            ));
          }
        },
      ),
    );
  }
}
