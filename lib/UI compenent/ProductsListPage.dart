import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/TopPage.dart';
import '../Repo/GeneralModel.dart';
import '../Repo/GeneralRepo.dart';
import 'ProductPage.dart';
import '../Repo/Databaserepo.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;
  late Future<List<Product>> databaseProducts;

  List<Product> _products = [];

  List<Product> _searchResult = [];
  final databaseObject = ProductRepository();
  final List<String> allitems = <String>[
    'Technology',
    'Mobiles',
    'Clothes',
    'Women',
  ];
  @override
  void initState() {
    super.initState();

    futureProducts = loadProducts();
    databaseProducts = databaseObject.readProducts();

    databaseProducts.then((products) => setState(() {
          _products = products;

          _searchResult = products;
        }));
  }

  void _onSearch(String value) {
    setState(() {
      _searchResult = _products
          .where((product) =>
              product.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  int randomInteger() {
    return Random().nextInt(5) + 1;
  }

  Widget _buildCard(BuildContext context, Product product) {
    int number = randomInteger();
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)),
          );
        },
        child: Card(
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: const Color.fromARGB(255, 209, 209, 209), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(product.name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8.0),
                          Text('\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16.0)),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          // Adjusted here
                          'assets/images/image$number.jpg',
                          height: 72,
                          width: 72,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopPageWidget(
            title: "All Products",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                return _buildCard(context, _searchResult[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}



/*
ListTile(
                title: Text(_searchResult[index].name),
                subtitle:
                    Text('\$${_searchResult[index].price.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: _searchResult[index])),
                  );
                },
              );
*/