import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({
    super.key,
    this.width,
    this.margin,
    required this.child,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.hintColor.withAlpha(10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}