import 'dart:convert';
import 'package:flutter/services.dart';
import 'GeneralModel.dart';

Future<List<Product>> loadProducts() async {
  String jsonString = await rootBundle.loadString('assets/products.json');
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((item) => Product.fromJson(item)).toList();
}
