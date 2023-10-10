import 'package:bloc/bloc.dart';
import '../Repo/GeneralModel.dart';
import 'GeneralEvent.dart';
import 'GeneralState.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final _cartItems = <Product>[];

  CartBloc() : super(CartInitialState()) {
    on<AddToCart>((event, emit) {
      _cartItems.add(event.product);
      emit(CartUpdateState(_cartItems));
    });

    on<RemoveFromCart>((event, emit) {
      _cartItems.remove(event.product);
      emit(CartUpdateState(_cartItems));
    });
  }
}




/*

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState());
  List<Product> bloccartItems = [];

  @override
  onEvent(CartEvent event) async* {
    super.onEvent(event);
    if (event is AddToCart) {
      bloccartItems.add(event.product);
    } else if (event is RemoveFromCart) {
      bloccartItems.remove(event.product);
    }

    yield CartUpdateState(bloccartItems);
  }
}

*/