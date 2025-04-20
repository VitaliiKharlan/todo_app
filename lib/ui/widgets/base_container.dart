import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding = const EdgeInsets.only(left: 12),
    this.color,
    required this.child,
  });

  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
