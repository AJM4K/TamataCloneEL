import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BloC/GeneralBloc.dart';
import '../BloC/GeneralEvent.dart';
import '../Repo/GeneralModel.dart';
import '../widget/HeadingWidget.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  int randomInteger() {
    return Random().nextInt(5) + 1;
  }

  @override
  Widget build(BuildContext context) {
    int number = randomInteger();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeadingWidget(product: product),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              // Adjusted here
                              'assets/images/image$number.jpg',
                              height: 272,
                              width: 272,
                              fit: BoxFit.cover,
                            ),
                          ), // Placeholder for image
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${product.seller}',
                                    style: TextStyle(fontSize: 12)),
                                Container(
                                  margin: EdgeInsets.only(top: 7, bottom: 7),
                                  height: 0.2,
                                  width: 120,
                                  color: Color.fromARGB(255, 219, 219, 219),
                                ),
                                Text(product.name,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  margin: EdgeInsets.only(top: 7, bottom: 7),
                                  height: 0.2,
                                  width: 120,
                                  color: Color.fromARGB(255, 175, 175, 175),
                                ),
                                Text('${product.price.toStringAsFixed(2)} IQD',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red)),
                                SizedBox(height: 16.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          color: Color.fromARGB(
                                              159, 241, 241, 241),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Icon(Icons.check),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.all(7),
                                                  child: Text(
                                                    '100% Quality Assurance',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                    textAlign: TextAlign
                                                        .center, // Set text alignment to center
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          color: Color.fromARGB(
                                              159, 241, 241, 241),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(7),
                                                child:
                                                    Icon(Icons.card_giftcard),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.all(7),
                                                  child: Text('Secure payments',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: Card(
                                          color: Color.fromARGB(
                                              159, 241, 241, 241),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(7),
                                                child: Icon(Icons.lock_clock),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.all(7),
                                                  child: Text(
                                                      'Delivery on time',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Overview and Description',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16.0),
                                Text('${product.description}',
                                    style: TextStyle(fontSize: 12)),
                                SizedBox(height: 16.0),
                                SizedBox(height: 16.0),
                                SizedBox(height: 16.0),
                                SizedBox(height: 16.0),
                                SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    // Add your add to cart functionality here
                    BlocProvider.of<CartBloc>(context).add(AddToCart(product));
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Added to Cart'),
                          content: Text(
                              '${product.name} has been added to your cart.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Continue Shopping'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




/*
   floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(AddToCart(product));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Added to Cart'),
                content: Text('${product.name} has been added to your cart.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Continue Shopping'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        label: Row(children: <Widget>[
          Icon(Icons.add_shopping_cart),
          SizedBox(width: 5.0),
          Text("Add to Cart")
        ]),
      ),
  
*/