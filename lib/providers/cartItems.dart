import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<ProductModel> product = [];

  addProduct(ProductModel productModel) {
    product.add(productModel);
    notifyListeners();
  }

  deleteProduct(ProductModel productModel){
    product.remove(productModel);
    notifyListeners();
  }
}
