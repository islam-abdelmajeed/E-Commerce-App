import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/modules/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/providers/cartItems.dart';
import 'package:e_commerce_app/providers/counter_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfoScreen extends StatelessWidget {
  static String id = 'productInfo';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final CountProduct count = Provider.of<CountProduct>(context);
    final CartItem cart = Provider.of<CartItem>(context);
    ProductModel product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Image(
              image: NetworkImage(
                product.pLocation,
              ),
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      CartScreen.id,
                    );
                  },
                  icon: Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Container(
                  color: Colors.white.withOpacity(0.5),
                  height: height * 0.3,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              product.pName,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.1,
                            ),
                            Text(
                              '\$${product.pPrice}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.007,
                        ),
                        Text(
                          product.pDescription,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              onPressed: () => count.decrease(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: kSecondaryColor,
                              height: height * 0.08,
                              minWidth: width * 0.17,
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              count.counter.toString(),
                              style: TextStyle(
                                fontSize: 50.0,
                                fontWeight: FontWeight.w900,
                                color: kMainColor,
                              ),
                            ),
                            MaterialButton(
                              onPressed: () => count.increase(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: kSecondaryColor,
                              height: height * 0.08,
                              minWidth: width * 0.17,
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  child: Text(
                    'Add to cart'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  onPressed: () {
                    product.count = count.counter;
                    var productsInCart = cart.product;
                    bool exist = false;
                    for (var productInCart in productsInCart) {
                      if (productInCart.pName == product.pName) {
                        exist = true;
                      }
                    }
                    if (exist) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('you\'ve added this item before.'),
                        ),
                      );
                    }else{
                      cart.addProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to your cart'),
                        ),
                      );
                      count.counter = 1;
                    }
                  },
                  color: kMainColor,
                  minWidth: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
