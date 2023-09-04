import 'package:flutter/material.dart';

class BrandDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  const BrandDivider({
    Key? key,
    this.color,
    this.height,
    this.thickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1.0,
      color: color,
      thickness: thickness ?? 1.0,
    );
  }
}
