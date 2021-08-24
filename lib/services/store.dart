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

  Stream<QuerySnapshot> loadOrders() {
    return fireStore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return fireStore
        .collection(kOrders)
        .doc(documentId)
        .collection(kOrdersDetails)
        .snapshots();
  }

  deleteProduct(documentId) {
    fireStore.collection(kProducts).doc(documentId).delete();
  }

  editProduct(data, documentId) {
    fireStore.collection(kProducts).doc(documentId).update(data);
  }

  storeOrders(data, List<ProductModel> products) {
    var documentRef = fireStore.collection(kOrders).doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection(kOrdersDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kCount: product.count,
        kProductLocation: product.pLocation,
        kProductCategory:product.pCategory,
      });
    }
  }
}
