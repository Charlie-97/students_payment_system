import 'package:flutter/material.dart';

// class AppDimensions {
//   static const double SMALLEST = 8.5;
//   static const double FONT_SIZE_EXTRA_SMALL = 10.0;
//   static const double FONT_SIZE_SMALL = 12.0;
//   static const double FONT_SIZE_DEFAULT = 14.0;
//   static const double FONT_SIZE_LARGE = 16.0;
//   static const double FONT_SIZE_EXTRA_LARGE = 20.0;
//   static const double FONT_SIZE_OVER_LARGE = 24.0;
//   static const double FONT_SIZE_MEDIUM = 12.0;
//   static const double FONT_SIZE_NORMAL_LARGE = 18.0;

//   static const double PADDING_SIZE_EXTRA_SMALL = 10.0;
//   static const double PADDING_SIZE_SMALL = 12.0;
//   static const double PADDING_SIZE_DEFAULT = 15.0;
//   static const double PADDING_SIZE_MEDIUM = 20.0;
//   static const double PADDING_SIZE_LARGE = 25.0;
//   static const double PADDING_SIZE_EXTRA_LARGE = 30.0;
// }

yMargin(double height) {
  return SizedBox(
    height: height,
  );
}

xMargin(double width) {
  return SizedBox(
    width: width,
  );
}

class Screensize {
  static double height(BuildContext context) {
    final double h = MediaQuery.sizeOf(context).height;
    return h;
  }

  static double width(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return w;
  }
}
