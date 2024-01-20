import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:students_payment_system/models/cart_item_model.dart';
import 'package:students_payment_system/presentation/pages/screens/product_details.dart';
import 'package:students_payment_system/presentation/widgets/app_bar.dart';
import 'package:students_payment_system/presentation/widgets/empty_cart.dart';
import 'package:students_payment_system/presentation/widgets/item_in_cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routeName = 'cart_page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Cart'),
      body: dummyCart.isEmpty ? const EmptyCart() : const ItemsInCart(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: getMarkedItemsCount() == 0
            ? OutlineButtonWidget(
                onPressed: () {
                  return;
                },
                btnName: 'Process Payment',
              )
            : Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Process Payment',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  int getMarkedItemsCount() {
    int count = 0;
    for (CartItem item in dummyCart) {
      if (item.isMarked) {
        count++;
      }
    }
    return count;
  }
}
