import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BloC/GeneralBloc.dart';
import '../BloC/GeneralEvent.dart';
import '../Repo/GeneralModel.dart';
import 'ProductPage.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.context,
    required this.product,
  });

  final BuildContext context;
  final Product product;

  int randomInteger() {
    return Random().nextInt(5) + 1;
  }

  @override
  Widget build(BuildContext context) {
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
                        ), // Placeholder for image
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveFromCart(product));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
