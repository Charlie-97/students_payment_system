import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:students_payment_system/bloc/cart_bloc.dart';
import 'package:students_payment_system/presentation/widgets/app_bar.dart';
import 'package:students_payment_system/services/apis/auth_service.dart';
import 'package:students_payment_system/services/model/cart_model.dart';
import 'package:students_payment_system/utils/constants.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});
//   static const routeName = 'cart_page';

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget(context, 'Cart'),
//       body: dummyCart.isEmpty ? const EmptyCart() : const ItemsInCart(),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//         child: getMarkedItemsCount() == 0
//             ? OutlineButtonWidget(
//                 onPressed: () {
//                   return;
//                 },
//                 btnName: 'Process Payment',
//               )
//             : Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     'Process Payment',
//                     style: TextStyle(
//                       fontFamily: 'Montserrat',
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }

//   int getMarkedItemsCount() {
//     int count = 0;
//     for (CartItem item in dummyCart) {
//       if (item.isMarked) {
//         count++;
//       }
//     }
//     return count;
//   }
// }

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
      appBar: appBarWidget(context, 'Description', showAction: true),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartLoaded) {
            if (state.cartItems.isEmpty) {
              return const Center(child: Text('No items in cart'));
            }
            // num sum = 0, point = 0;
            // List<double> getPrice = [];
            // List<num> getPoint = [];
            // for (var item in state.cartItems) {
            //   getPrice.add(double.parse(item.price) * item.quantity);
            //   getPoint.add(item.points * item.quantity);
            // }

            // for (var e in getPrice) {
            //   sum += e;
            // }
            // for (var e in getPoint) {
            //   point += e;
            // }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                '${state.cartItems.length} items',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ListView.builder(
                              itemCount: state.cartItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                CartData cart = state.cartItems[index];

                                return Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 14),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            'productDetails',
                                            arguments: state.cartItems[index],
                                          );
                                        },
                                        child: Container(
                                          height: 64,
                                          width: 63,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: const DecorationImage(
                                              // image: NetworkImage(cart.pimage),
                                              image: AssetImage(
                                                'assets/images/download.jpeg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 14,
                                                width: double.infinity,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                child: Center(
                                                  child: Text(
                                                    '${cart.points} Point(s)',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  cart.productName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          DeleteCartEvent(
                                                            cart: cart,
                                                          ),
                                                        );
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 12,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      cart.storename,
                                                      style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  '$naira 12,000',
                                                  style: TextStyle(
                                                    color: Colors.deepPurple,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Delivery in 3 - 5 days',
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (cart.quantity > 1) {
                                                          context
                                                              .read<CartBloc>()
                                                              .add(
                                                                UpdateCartEvent(
                                                                  cart: cart
                                                                      .copyWith(
                                                                    quantity:
                                                                        cart.quantity -
                                                                            1,
                                                                  ),
                                                                ),
                                                              );
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 13,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: cart.quantity ==
                                                                  1
                                                              ? Colors.grey
                                                                  .withOpacity(
                                                                      0.4)
                                                              : Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            '−',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontFamily:
                                                                  'Avenier Bold',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    Text(
                                                      '${cart.quantity}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 6),
                                                    GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<CartBloc>()
                                                            .add(
                                                              UpdateCartEvent(
                                                                cart: cart
                                                                    .copyWith(
                                                                  quantity:
                                                                      cart.quantity +
                                                                          1,
                                                                ),
                                                              ),
                                                            );
                                                      },
                                                      child: Container(
                                                        height: 13,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            '+',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontFamily:
                                                                  'Avenier Bold',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Points',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '0 Points',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '$naira 12,100',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Avenier Bold',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    Consumer<AuthService>(
                      builder: (context, state, child) {
                        return state.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                  onPressed: () {
                                    state.paymentlink(context);
                                  },
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
