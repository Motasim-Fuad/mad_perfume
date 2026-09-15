class CartItem {
  const CartItem({
    required this.productId,
    required this.name,
    required this.volume,
    required this.imageUrl,
    required this.price,
    required this.collectionId,
    required this.quantity,
  });

  final String productId;
  final String name;
  final String volume;
  final String imageUrl;
  final double price;
  final String collectionId;
  final int quantity;

  double get lineTotal => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      name: name,
      volume: volume,
      imageUrl: imageUrl,
      price: price,
      collectionId: collectionId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'volume': volume,
        'imageUrl': imageUrl,
        'price': price,
        'collectionId': collectionId,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as String,
      name: json['name'] as String,
      volume: json['volume'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      collectionId: json['collectionId'] as String,
      quantity: json['quantity'] as int,
    );
  }
}
