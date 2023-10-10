import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/TopPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BloC/GeneralBloc.dart';
import '../BloC/GeneralEvent.dart';
import '../BloC/GeneralState.dart';
import '../Repo/GeneralModel.dart';
import 'CartWidget.dart';

class CartPage extends StatelessWidget {
  // Extracted the list item building logic into a separate method for better readability.
  Widget _buildListItem(BuildContext context, Product product) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_shopping_cart),
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(RemoveFromCart(product));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TopPageWidget(title: "My Cart"),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartUpdateState) {
                  return ListView.builder(
                    itemCount: state.cart.length,
                    itemBuilder: (context, index) => CartWidget(
                        context: context, product: state.cart[index]),
                  );
                } else {
                  return Center(child: Text("No items in cart."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
