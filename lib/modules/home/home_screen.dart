import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/modules/product_info/product_info_screen.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  int bottomIndex = 0;
  final store = Store();
  List<ProductModel> _products;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Man',
                    style: TextStyle(
                      color: tabIndex == 0 ? Colors.black : kUnSelectColor,
                      fontSize: tabIndex == 0 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Women',
                    style: TextStyle(
                      color: tabIndex == 1 ? Colors.black : kUnSelectColor,
                      fontSize: tabIndex == 1 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Baby',
                    style: TextStyle(
                      color: tabIndex == 2 ? Colors.black : kUnSelectColor,
                      fontSize: tabIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      color: tabIndex == 3 ? Colors.black : kUnSelectColor,
                      fontSize: tabIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: kMainColor,
              unselectedItemColor: kUnSelectColor,
              showUnselectedLabels: true,
              onTap: (value) {
                setState(() {
                  bottomIndex = value;
                });
              },
              currentIndex: bottomIndex,
              items: [
                BottomNavigationBarItem(
                  label: 'Just Test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Just Test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Just Test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Just Test',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            body: TabBarView(
              children: [
                manView(),
                productView(kWomen, _products),
                productView(kBaby, _products),
                productView(kShoes, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget manView() {
    return StreamBuilder<QuerySnapshot>(
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
          _products = [...products];
          products.clear();
          products = getProductCategory(kMan, _products);
          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductInfoScreen.id,
                        arguments: products[index]);
                  },
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.height - dy;
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [],
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
    );
  }
}
