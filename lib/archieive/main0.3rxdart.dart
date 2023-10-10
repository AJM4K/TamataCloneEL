import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CartBloc cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eCommerce Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(cartBloc: cartBloc),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String seller;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.seller});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      seller: json['seller'],
    );
  }
}

Future<List<Product>> loadProducts() async {
  String jsonString = await rootBundle.loadString('assets/products.json');
  List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((item) => Product.fromJson(item)).toList();
}

class CartBloc {
  final _cart = BehaviorSubject<List<Product>>.seeded([]);

  Stream<List<Product>> get cartStream => _cart.stream;

  List<Product> get currentCart => _cart.value;

  void addToCart(Product product) {
    currentCart.add(product);
    _cart.sink.add(currentCart);
  }

  void removeFromCart(Product product) {
    currentCart.remove(product);
    _cart.sink.add(currentCart);
  }

  void dispose() {
    _cart.close();
  }
}

class ProductListPage extends StatefulWidget {
  final CartBloc cartBloc;

  ProductListPage({required this.cartBloc});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;
  List<Product> _products = [];
  List<Product> _searchResult = [];

  @override
  void initState() {
    super.initState();
    futureProducts = loadProducts();
    futureProducts.then((products) => setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(cartBloc: widget.cartBloc)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
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
                return ListTile(
                  title: Text(_searchResult[index].name),
                  subtitle: Text(
                      '\$${_searchResult[index].price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              product: _searchResult[index],
                              cartBloc: widget.cartBloc)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Product product;

  final CartBloc cartBloc;

  ProductDetailPage({required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ID: ${product.id}', style: TextStyle(fontSize: 20)),
            Text('Description: ${product.description}',
                style: TextStyle(fontSize: 20)),
            Text('Price: \$${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20)),
            Text('Seller: ${product.seller}', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                cartBloc.addToCart(product);
              },
              child: Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final CartBloc cartBloc;

  CartPage({required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: cartBloc.cartStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(
                      '\$${snapshot.data![index].price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartBloc.removeFromCart(snapshot.data![index]);
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
