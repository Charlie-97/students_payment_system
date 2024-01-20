import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:students_payment_system/bloc/cart_bloc.dart';
import 'package:students_payment_system/presentation/widgets/app_bar.dart';
import 'package:students_payment_system/services/model/cart_model.dart';
import 'package:students_payment_system/theme/text_theme.dart';
import 'package:students_payment_system/utils/dimensions.dart';
import 'package:students_payment_system/utils/icons.dart';
import 'package:uuid/uuid.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});
  static const routeName = 'product_detail';

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isLiked = false;
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Description', showAction: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Screensize.height(context) * .35,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/download.jpeg',
                  fit: BoxFit.fill,
                ),
              ),
              const Gap(9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product name',
                        style: AppTextTheme.bodyLarge(context),
                      ),
                      const Gap(6),
                      const Text(
                        '\$12,000',
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 32,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  const Icon(
                    UIcons.Shop,
                    size: 40,
                  ),
                  const Gap(12),
                  const Text('Jiga Store'),
                  const Expanded(child: SizedBox()),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      side: BorderSide(
                          color: isFollowed ? Colors.black : Colors.deepPurple,
                          width: 0.4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    onPressed: () {
                      setState(() {
                        isFollowed = !isFollowed;
                      });
                    },
                    child: Text(
                      isFollowed ? 'Followed' : 'Follow',
                      style: AppTextTheme.bodyMedium(context).copyWith(
                          fontSize: 14,
                          color: isFollowed ? Colors.black : Colors.deepPurple),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[100],
                thickness: 1,
              ),
              Text(
                'Product Description',
                style: AppTextTheme.bodyLarge(context),
              ),
              const Gap(9),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."',
                style: AppTextTheme.bodySmall(context),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: OutlineButtonWidget(
                  onPressed: () async {
                    CartData cartData = CartData(
                      id: const Uuid().v4().toString(),
                      productName: "widget.data.productName",
                      carouselImg: const ["widget.data.carouselImg"],
                      price: "widget.data.price",
                      category: "widget.data.category",
                      desc: "widget.data.desc",
                      pimage: "widget.data.pimage",
                      points: 9,
                      ratingCount: "23",
                      status: "false",
                      stock: "widget.data.stock",
                      storeid: "widget.data.storeid",
                      storename: "widget.data.storename",
                      totalrating: "widget.data.totalrating",
                      quantity: 1,
                    );
                    context.read<CartBloc>().add(AddCartEvent(cart: cartData));
                    showModalBottomSheet(
                      context: context,
                      elevation: 0,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0, bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        const Icon(UIcons.shopping_bag),
                                        // SvgPicture.asset(
                                        //   'assets/svgs/circle_check.svg',
                                        //   color: Colors.green,
                                        // ),
                                        const SizedBox(height: 28),
                                        const Text(
                                          'Product successfully added to your Shopping Cart',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          state is CartLoaded
                                              ? 'You now have ${state.cartItems.length} products in your Shopping Cart'
                                              : '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 32),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, 'shoppingCartRoute');
                                          },
                                          child: const Text(
                                            'View Shopping Cart',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          // txt: 'View Shopping Cart',
                                        ),
                                        const SizedBox(height: 15),
                                        OutlineButtonWidget(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          btnName: 'Continue Shopping',
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
