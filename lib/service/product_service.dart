import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class ProductService {
  static Stream<List<Product>> readProduct() => FirebaseFirestore.instance
      .collection('accessory')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
}
