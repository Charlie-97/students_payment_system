import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_payment_system/bloc/cart_bloc.dart';
import 'package:students_payment_system/presentation/pages/cart_page.dart';
import 'package:students_payment_system/utils/icons.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

PreferredSizeWidget appBarWidget(BuildContext context, String txt,
    {bool showAction = false, showLeading = true, String? type}) {
  return AppBar(
    title: Text(
      txt,
      style: const TextStyle(
        fontSize: 22,
        fontFamily: "Montserrat",
      ),
    ),
    automaticallyImplyLeading: showLeading,
    actions: showAction
        ? [
            type == 'cart'
                ? const Center()
                : BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        if (state.cartItems.isEmpty) {
                          return IconButton(
                            onPressed: () =>
                                BaseNavigator.pushNamed(CartPage.routeName),
                            icon: const Icon(UIcons.shopping_cart),
                          );
                        }
                        return Stack(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  BaseNavigator.pushNamed(CartPage.routeName),
                              icon: const Icon(UIcons.shopping_cart),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, top: 6),
                              child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.deepPurple),
                                ),
                                child: Center(
                                  child: Text(
                                    "${state.cartItems.length}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return IconButton(
                          onPressed: () =>
                              BaseNavigator.pushNamed(CartPage.routeName),
                          icon: const Icon(UIcons.shopping_cart),
                        );
                      }
                    },
                  ),
            type == 'notification'
                ? const Center()
                : Stack(
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'inboxRoute'),
                        icon: const Icon(UIcons.notification),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 6),
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ]
        : null,
  );
}
