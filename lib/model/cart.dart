class CartItem {
  final String id;
  final String productName;
  final String productUrl;
  int quantity;
  final double price;
  CartItem({
    required this.id,
    required this.productName,
    required this.productUrl,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productUrl': productUrl,
      'quantity': quantity,
      'price': price,
    };
  }

  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productName: map['productName'] as String,
      productUrl: map['productUrl'],
      quantity: map['quantity'] as int,
      price: map['price'] as double,
    );
  }
}
