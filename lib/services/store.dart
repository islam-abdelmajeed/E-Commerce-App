import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';

class Store {
  final fireStore = FirebaseFirestore.instance;

  addProduct(ProductModel model) {
    fireStore.collection(kProducts).add({
      kProductName: model.pName,
      kProductPrice: model.pPrice,
      kProductDescription: model.pDescription,
      kProductCategory: model.pCategory,
      kProductLocation: model.pLocation,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return fireStore.collection(kProducts).snapshots();
  }

  deleteProduct(documentId) {
    fireStore.collection(kProducts).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    fireStore.collection(kProducts).doc(documentId).update(data);
  }
}
