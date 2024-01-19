import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:students_payment_system/presentation/pages/screens/product_details.dart';
import 'package:students_payment_system/utils/constants.dart';
import 'package:students_payment_system/utils/dimensions.dart';
import 'package:students_payment_system/utils/icons.dart';
import 'package:students_payment_system/utils/router/base_navigator.dart';

class DashboardPage extends HookWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.2);

    var search = useTextEditingController();
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
      Colors.cyan,
      Colors.lime,
      Colors.amber,
      Colors.grey,
    ];
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: search,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                // labelText: 'Email',
                isDense: true,
                hintText: '...endless search',
                hintStyle: const TextStyle(
                  fontSize: 14,
                ),
                // hintStyle: Theme.of(context).textTheme.bodySmall,
                prefixIcon: const Icon(UIcons.search_normal, size: 18),
                prefixIconColor: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            // const SizedBox(
            //   height: 12.0,
            // ),
            yMargin(12),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.73,
                crossAxisSpacing: 0.5,
              ),
              itemCount: 30,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    BaseNavigator.pushNamed(ProductDetail.routeName);
                  },
                  child: Container(
                    height: 200,
                    width: 173,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 14.22,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // border: Border(
                      //   right: BorderSide(width: 0.3),
                      //   bottom: BorderSide(width: 0.3),
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 162,
                          width: double.infinity,
                          // color: AppColor.grey,
                          decoration: BoxDecoration(
                            color: getRandomElement(colors),
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/download.jpeg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "$index. This is a very long text that should be truncated",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 2,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              UIcons.Shop,
                              size: 12,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "Jiga Store",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.black.withOpacity(0.3),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          '$naira 1,200',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  T getRandomElement<T>(List<T> list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }
}
