import 'package:flutter/material.dart';
import 'package:flutter_application_1/UI%20compenent/SearchPage.dart';
import 'package:flutter_application_1/widget/Theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'BloC/GeneralBloc.dart';
import 'Repo/Databaserepo.dart';
import 'UI compenent/CartPage.dart';
import 'UI compenent/CatagoryListPage.dart';
import 'UI compenent/HomePage.dart';
import 'UI compenent/ProductsListPage.dart';

Future<void> main() async {
  runApp(
    BlocProvider(
      create: (context) => CartBloc(),
      child: MyApp(),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  final repo = ProductRepository();

  // Load the products from the JSON file into the database
  await repo.loadProducts();
}

class MyApp extends StatelessWidget {
  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce Demo',
      theme: ThemeInfo(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final tabs = [
    HomePage(),
    CatagoryPage(),
    ProductListPage(),
    SearchPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cabin),
            label: 'Catagory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'All products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
