import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    this.height,
    this.width,
    this.margin,
    required this.child,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}