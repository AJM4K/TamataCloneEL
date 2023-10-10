import '../Repo/GeneralModel.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartUpdateState extends CartState {
  List<Product> cart;

  CartUpdateState(this.cart);
}
