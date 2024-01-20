
import 'package:flutter/material.dart';
import 'package:students_payment_system/models/cart_item_model.dart';
import 'package:students_payment_system/presentation/widgets/cart_item_tile.dart';

class ItemsInCart extends StatelessWidget {
  const ItemsInCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyCart.length,
      itemBuilder: (context, index) {
        return CartItemTile(
          isMarked: dummyCart[index].isMarked,
          productImage: dummyCart[index].productimage,
          productName: dummyCart[index].productTitle,
          productOptions: dummyCart[index].variant,
          price: dummyCart[index].price,
          qty: dummyCart[index].qty,
        );
      },
    );
  }
}
