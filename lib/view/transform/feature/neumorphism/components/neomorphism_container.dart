import 'package:flutter/material.dart';

class NeoMorphismContainer extends StatelessWidget {
  const NeoMorphismContainer({
    Key? key,
    this.height = 150,
    this.width = 150,
    this.offset = 4,
    this.blurRadius = 15,
    this.foregroundColor,
    this.primaryShadowColor,
    this.secondaryShadow,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    required this.child,
  }) : super(key: key);

  final Widget child;

  final double height;
  final double width;
  final double blurRadius;
  final Color? primaryShadowColor;
  final Color? secondaryShadow;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;
  final double offset;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: shape,
          color: foregroundColor ?? Colors.grey.shade300,
          borderRadius: shape == BoxShape.circle
              ? null
              : borderRadius ?? BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(

              color: secondaryShadow ?? Colors.grey.shade400,
              offset: Offset(offset, offset),
              blurRadius: blurRadius,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: primaryShadowColor ?? Colors.grey.shade50,
              offset: Offset(-offset, -offset),
              blurRadius: blurRadius,
              spreadRadius: 1,
            )
          ]),
      child: Center(child: child),
    );
  }
}
