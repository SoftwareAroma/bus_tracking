import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';

class TwoLineItem extends StatelessWidget {
  final String firstText, secondText;

  const TwoLineItem({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomText(
          firstText,
          color: BrandColors.kColorDarkGreen,
          fontSize: 12.0,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          overflow: TextOverflow.ellipsis,
        ),
        CustomText(
          secondText,
          color: BrandColors.kColorDarkGreen,
          fontSize: 10.0,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
