import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:students_payment_system/utils/constants.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile(
      {super.key,
      required this.isMarked,
      required this.productImage,
      required this.productName,
      required this.productOptions,
      required this.price,
      required this.qty});
  final bool isMarked;
  final String productImage;
  final String productName;
  final String productOptions;
  final double price;
  final int qty;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    int qty = widget.qty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          widget.isMarked
              ? 'assets/images/checked_icon.svg'
              : 'assets/images/unchecked_icon.svg',
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        const Gap(9),
        SvgPicture.asset(
          'assets/images/${widget.productImage}',
          width: 82,
          height: 76,
        ),
        const Gap(10),
        Expanded(
            child: Column(
          children: [
            Text(widget.productName),
            const Gap(4),
            Text('Variant: ${widget.productOptions}'),
            const Gap(14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    naira + widget.price.toString(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (qty >= 1) {
                        qty -= 1;
                      }
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/remove_icon.dart',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Gap(8),
                Text(widget.qty.toString()),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      qty += 1;
                    });
                  },
                  child: SvgPicture.asset(
                    'assets/images/add_icon.dart',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: SvgPicture.asset(
                    'assets/images/delete_icon.dart',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            )
          ],
        ))
      ],
    );
  }
}
