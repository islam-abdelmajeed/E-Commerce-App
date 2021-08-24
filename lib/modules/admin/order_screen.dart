import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:e_commerce_app/modules/admin/order_details.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<OrderModel> orders = [];
    Store store = Store();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              orders.add(OrderModel(
                documentId: doc.id,
                address: doc[kAddress],
                totalPrice: doc[kTotalPrice],
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailsScreen.id,
                            arguments: orders[index].documentId,
                          );
                        },
                        child: Container(
                          height: height * 0.2,
                          color: kSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price = \$${orders[index].totalPrice}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                  'Address is : ${orders[index].address}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: customButton(
                          text: 'Confirm Order',
                          function: () {},
                          color: kMainColor,
                          textColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Expanded(
                        child: customButton(
                          text: 'Delete Order',
                          function: () {},
                          color: kMainColor,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: Text(
              'There is no orders.',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black54,
              ),
            ));
          }
        },
      ),
    );
  }
}
