import 'package:flutter/material.dart';
import 'package:students_payment_system/presentation/widgets/app_bar.dart';
import 'package:students_payment_system/utils/icons.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
  static const routeName = 'product_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Description', showAction: true),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: OutlineButtonWidget(
            onPressed: () async {
              // CartData cartData = CartData(
              //   id: widget.data.id,
              //   productName: widget.data.productName,
              //   carouselImg: widget.data.carouselImg,
              //   price: widget.data.price,
              //   category: widget.data.category,
              //   desc: widget.data.desc,
              //   pimage: widget.data.pimage,
              //   points: widget.data.points,
              //   ratingCount: widget.data.ratingCount,
              //   status: widget.data.status,
              //   stock: widget.data.stock,
              //   storeid: widget.data.storeid,
              //   storename: widget.data.storename,
              //   totalrating: widget.data.totalrating,
              //   quantity: 1,
              // );
              // context.read<CartBloc>().add(AddCartEvent(cart: cartData));
              // showModalBottomSheet(
              //   context: context,
              //   elevation: 0,
              //   isScrollControlled: true,
              //   backgroundColor: Colors.transparent,
              //   builder: (context) {
              //     return BlocBuilder<CartBloc, CartState>(
              //       builder: (context, state) {
              //         return BottomSheetWidget(
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //             child: Column(
              //               children: [
              //                 SizedBox(height: 30),
              //                 Icon(UIcons.shopping_bag)
              //                 // SvgPicture.asset(
              //                 //   'assets/svgs/circle_check.svg',
              //                 //   color: Colors.green,
              //                 // ),
              //                 SizedBox(height: 28),
              //                 Text(
              //                   'Product successfully added to your Shopping Cart',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     color: Colors.deepPurple,
              //                     fontSize: 18,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //                 SizedBox(height: 12),
              //                 Text(
              //                   state is CartLoaded
              //                       ? 'You now have ${state.cartItems.length} products in your Shopping Cart'
              //                       : '',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //                 SizedBox(height: 32),
              //                 ButtonWidget(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                     Navigator.pushNamed(
              //                         context, 'shoppingCartRoute');
              //                   },
              //                   txt: 'View Shopping Cart',
              //                 ),
              //                 SizedBox(height: 15),
              //                 OutlineButtonWidget(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                   btnName: 'Continue Shopping',
              //                 ),
              //                 SizedBox(height: 10),
              //               ],
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  UIcons.shopping_bag,
                  size: 20,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineButtonWidget extends StatelessWidget {
  final String? btnName;
  final void Function() onPressed;
  final double? width;
  final Widget? child;
  const OutlineButtonWidget({
    Key? key,
    this.btnName,
    required this.onPressed,
    this.width,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: 45,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          side: const BorderSide(color: Colors.deepPurple, width: 0.4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        child: child ??
            FittedBox(
              child: Text(
                '$btnName',
                style: const TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
      ),
    );
  }
}
