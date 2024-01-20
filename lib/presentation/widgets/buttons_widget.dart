import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.enabled = true,
    this.size = 40,
    this.iconsize,
    this.color = Colors.grey,
    this.decoration,
    this.padding,
  }) : super(key: key);
  final void Function() onPressed;
  final IconData icon;
  final bool enabled;
  final double size;
  final double? iconsize;
  final Color color;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: decoration,
      child: MaterialButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        child: Icon(icon, color: color, size: iconsize),
      ),
    );
  }
}
