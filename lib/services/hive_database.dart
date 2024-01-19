import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_payment_system/services/model/cart_model.dart';

class MyDatabase {
  String boxName = 'cart_items';

  Future<Box> openBox() async {
    Box box = await Hive.openBox<CartData>(boxName);
    return box;
  }

  List<CartData> getCartItems(Box box) {
    return box.values.toList().cast<CartData>();
  }

  Future<void> addCartItem(Box box, CartData cart) async {
    await box.put(cart.id, cart);
  }

  Future<void> updateCartItem(Box box, CartData cart) async {
    await box.put(cart.id, cart);
  }

  Future<void> deleteCartItem(Box box, CartData cart) async {
    await box.delete(cart.id);
  }

  Future<void> deleteAllCartItems(Box box) async {
    await box.clear();
  }
}
