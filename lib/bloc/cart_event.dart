part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartLoadEvent extends CartEvent {}

class UpdateCartEvent extends CartEvent {
  final CartData cart;

  const UpdateCartEvent({required this.cart});

  @override
  List<Object> get props => [cart];
}

class AddCartEvent extends CartEvent {
  final CartData cart;

  const AddCartEvent({required this.cart});

  @override
  List<Object> get props => [cart];
}

class DeleteCartEvent extends CartEvent {
  final CartData cart;

  const DeleteCartEvent({required this.cart});

  @override
  List<Object> get props => [cart];
}

class DeleteAllCartEvent extends CartEvent {}
