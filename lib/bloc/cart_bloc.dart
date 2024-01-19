import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_payment_system/services/hive_database.dart';
import 'package:students_payment_system/services/model/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final MyDatabase myDatabase;
  CartBloc({required this.myDatabase}) : super(CartLoading()) {
    on<CartLoadEvent>(_onLoadCartItems);
    on<UpdateCartEvent>(_onUpdateCart);
    on<AddCartEvent>(_onAddCart);
    on<DeleteCartEvent>(_onDeleteCart);
    on<DeleteAllCartEvent>(_onDeleteAllCart);
  }

  void _onLoadCartItems(
    CartLoadEvent event,
    Emitter<CartState> emit,
  ) async {
    Future.delayed(const Duration(seconds: 1));
    Box box = await myDatabase.openBox();
    List<CartData> cartItems = myDatabase.getCartItems(box);
    emit(CartLoaded(cartItems: cartItems));
  }

  void _onUpdateCart(
    UpdateCartEvent event,
    Emitter<CartState> emit,
  ) async {
    Box box = await myDatabase.openBox();
    if (state is CartLoaded) {
      await myDatabase.updateCartItem(box, event.cart);
      emit(CartLoaded(cartItems: myDatabase.getCartItems(box)));
    }
  }

  void _onAddCart(
    AddCartEvent event,
    Emitter<CartState> emit,
  ) async {
    Box box = await myDatabase.openBox();
    if (state is CartLoaded) {
      await myDatabase.addCartItem(box, event.cart);
      emit(CartLoaded(cartItems: myDatabase.getCartItems(box)));
    }
  }

  void _onDeleteCart(
    DeleteCartEvent event,
    Emitter<CartState> emit,
  ) async {
    Box box = await myDatabase.openBox();
    if (state is CartLoaded) {
      await myDatabase.deleteCartItem(box, event.cart);
      emit(CartLoaded(cartItems: myDatabase.getCartItems(box)));
    }
  }

  void _onDeleteAllCart(
    DeleteAllCartEvent event,
    Emitter<CartState> emit,
  ) async {
    Box box = await myDatabase.openBox();
    if (state is CartLoaded) {
      await myDatabase.deleteAllCartItems(box);
      emit(CartLoaded(cartItems: myDatabase.getCartItems(box)));
    }
  }
}
