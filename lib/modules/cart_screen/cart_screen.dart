import 'package:e_commerce_app/component/component.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/modules/product_info/product_info_screen.dart';
import 'package:e_commerce_app/providers/cartItems.dart';
import 'package:e_commerce_app/services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'cartScreen';

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider
        .of<CartItem>(context)
        .product;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: products.length == 0
          ? Center(
        child: Text(
          'Your cart is empty.',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.black54,
          ),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTapUp: (details) {
                        showCustomMenu(details, context, products[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(height * 0.15 / 2),
                              bottomLeft: Radius.circular(height * 0.15 / 2),
                            )),
                        height: height * 0.15,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                              NetworkImage(products[index].pLocation),
                              radius: height * 0.15 / 2,
                            ),
                            SizedBox(
                              width: width * 0.07,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      products[index].count.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              itemCount: products.length,
            ),
          ),
          MaterialButton(
            onPressed: () {
              showCustomDialog(products, context);
            },
            minWidth: width,
            height: height * 0.08,
            color: kMainColor,
            child: Text(
              'Order'.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery
        .of(context)
        .size
        .width - dx;
    double dy2 = MediaQuery
        .of(context)
        .size
        .height - dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
          child: Text(
            'Edit',
          ),
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
            Navigator.pushNamed(context, ProductInfoScreen.id,
                arguments: product);
          },
        ),
        MyPopupMenuItem(
          child: Text(
            'Delete',
          ),
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .deleteProduct(product);
          },
        ),
      ],
    );
  }

  void showCustomDialog(List<ProductModel> products, context) async {
    var price = getTotalPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:Text(
          'Cancel',
          style: TextStyle(
            color: kMainColor,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ), ),
        TextButton(
          onPressed: () {
            try{
              Store store = Store();
              store.storeOrders({
                kTotalPrice: price,
                kAddress : address,
              }, products);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ordered Successfully.'),
                ),
              );

            }catch(ex){
              print(ex.message);
            }
          },
          child: Text(
            'Confirm',
            style: TextStyle(
              color: kMainColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
      title: Text('Total Price = \$ $price'),
      content: customTextField(
        onChange: (value){
          address =value;
        },
          hint: 'Enter your Address',
          icon: Icons.edit_location
      ),
    );
    await showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }

  getTotalPrice(List<ProductModel> products) {
    var price = 0;

    for (var product in products) {
      price += product.count * int.parse(product.pPrice);
    }
    return price;
  }
}
