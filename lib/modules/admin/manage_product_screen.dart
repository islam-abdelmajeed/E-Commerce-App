import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/modules/admin/edit_product_screen.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = [];

            for (var doc in snapshot.data.docs) {
              products.add(ProductModel(
                pId: doc.id,
                pName: doc[kProductName],
                pPrice: doc[kProductPrice],
                pDescription: doc[kProductDescription],
                pCategory: doc[kProductCategory],
                pLocation: doc[kProductLocation],
              ));
            }
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.height - dy;
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopupMenuItem(
                            child: Text(
                              'Edit',
                            ),
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                EditProductScreen.id,
                                arguments: products[index],
                              );
                            },
                          ),
                          MyPopupMenuItem(
                            child: Text(
                              'Delete',
                            ),
                            onClick: () {
                              store.deleteProduct(products[index].pId);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image(
                            image: NetworkImage(
                              products[index].pLocation,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            color: Colors.white.withOpacity(0.7),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${products[index].pName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '\$ ${products[index].pPrice}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: products.length,
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


