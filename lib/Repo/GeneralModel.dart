import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String seller;
  final String catagory;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.seller,
      required this.catagory});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      seller: json['seller'],
      catagory: json['catagory'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'seller': seller,
      'catagory': catagory
    };
  }
}
