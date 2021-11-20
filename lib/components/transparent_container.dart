import 'package:flutter/material.dart';

class ReusableTransparentContainer extends StatelessWidget {

  final Widget widget;
  final double borderRadius;
  final double colorOpacity;
  final double verticalPadding;
  final double horizontalPadding;

  const ReusableTransparentContainer({
    required this.borderRadius,
    required this.colorOpacity,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(colorOpacity),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: widget,
    );
  }
}