import 'package:flutter/material.dart';
import '../Repo/Databaserepo.dart';
import '../Repo/GeneralModel.dart';
import '../widget/CardWidget.dart';
import '../widget/TopPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Product>> databaseProducts;
  List<Product> _products = [];
  List<Product> _searchResult = [];
  final databaseObject = ProductRepository();

  @override
  void initState() {
    super.initState();
    databaseProducts = databaseObject.readProducts();

    databaseProducts.then((products) => setState(() {
          _products = products;

          _searchResult = products;
        }));
  }

  void _onSearch(String value) {
    setState(() {
      if (value == '') {
        _searchResult = [];
      } else {
        _searchResult = _products
            .where((product) =>
                product.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopPageWidget(
            title: 'Search Page',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _onSearch(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search product",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                return CardDesign(
                    context: context, product: _searchResult[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
