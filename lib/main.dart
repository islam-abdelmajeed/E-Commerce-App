import 'package:e_commerce_app/modules/admin/edit_product_screen.dart';
import 'package:e_commerce_app/modules/admin/order_details.dart';
import 'package:e_commerce_app/modules/cart_screen/cart_screen.dart';
import 'package:e_commerce_app/modules/login_module/login_screen.dart';
import 'package:e_commerce_app/modules/product_info/product_info_screen.dart';
import 'package:e_commerce_app/providers/admin_mode.dart';
import 'package:e_commerce_app/providers/cartItems.dart';
import 'package:e_commerce_app/providers/counter_product.dart';
import 'package:e_commerce_app/providers/modal_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(
          create: (BuildContext context) => ModalHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (BuildContext context) => AdminMode(),
        ),
        ChangeNotifierProvider<CountProduct>(
          create: (BuildContext context) => CountProduct(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (BuildContext context) => CartItem(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          EditProductScreen.id: (context) => EditProductScreen(),
          ProductInfoScreen.id: (context) => ProductInfoScreen(),
          OrderDetailsScreen.id: (context) => OrderDetailsScreen(),
          CartScreen.id: (context) => CartScreen(),
        },
      ),
    );
  }
}
