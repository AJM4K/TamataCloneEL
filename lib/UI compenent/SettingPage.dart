import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/HeadingWidget.dart';
import '../Repo/Databaserepo.dart';
import '../Repo/GeneralModel.dart';
import '../widget/CardWidget.dart';
import '../widget/TopPage.dart';
import '../widget/headwithbackwidget.dart';

class CatagoryListPage extends StatefulWidget {
  final String searchString;

  CatagoryListPage({required this.searchString});
  @override
  _CatagoryListPageState createState() => _CatagoryListPageState(searchString);
}

class _CatagoryListPageState extends State<CatagoryListPage> {
  final String searchString;

  late Future<List<Product>> databaseProducts;
  List<Product> _products = [];
  List<Product> _searchResult = [];
  final databaseObject = ProductRepository();
  _CatagoryListPageState(this.searchString);
  @override
  void initState() {
    super.initState();
    loadProducts(); // Adjusted here
  }

  Future<void> loadProducts() async {
    // Adjusted here
    _products = await databaseObject.readProducts();
    _searchResult = _products
        .where((product) =>
            product.catagory.toLowerCase() == searchString.toLowerCase())
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Headingwithback(
              search: searchString,
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
      ),
    );
  }
}
