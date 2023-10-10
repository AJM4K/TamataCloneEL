// repo/product_repository.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'GeneralModel.dart';

class ProductRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_newdatabase.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, price REAL, seller TEXT, catagory TEXT)",
        );
      },
      version: 1,
    );

    return _database!;
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;

    await db.insert(
      'products',
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> loadProducts() async {
    final String jsonString =
        await rootBundle.loadString('assets/products.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    final products =
        jsonResponse.map((item) => Product.fromJson(item)).toList();

    for (final product in products) {
      await insertProduct(product);
    }

    return products;
  }

  Future<List<Product>> readProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromJson(maps[i]);
    });
  }
}
