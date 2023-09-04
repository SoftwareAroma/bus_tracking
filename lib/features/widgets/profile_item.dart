import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final double? letterSpacing;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final void Function() onPressed;
  const ProfileItem({
    Key? key,
    required this.title,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.letterSpacing,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 10.0,
          vertical: verticalPadding ?? 8.0,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? BrandColors.kColorDarkGreen,
          borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
        ),
        child: Row(
          children: <Widget>[
            Text(
              title.toTitleCase(),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: textColor ?? BrandColors.kColorWhiteAccent,
                fontSize: fontSize ?? 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
