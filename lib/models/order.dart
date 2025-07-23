import 'dart:convert';

import 'package:amazon/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final double totalAmount;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.totalAmount,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
  });

  //json serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((p) => p.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'totalAmount': totalAmount,
      'orderedAt': orderedAt,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        map['products']?.map((x) => Product.fromMap(x['product'])),
      ),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
