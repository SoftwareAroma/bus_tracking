import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing;
  final double? horizontalMargin;
  final double? verticalMargin;
  final double? height;

  const CustomText(
    this.text, {
    Key? key,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.letterSpacing,
    this.horizontalMargin,
    this.verticalMargin,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 5.0,
        vertical: verticalMargin ?? 5.0,
      ),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        overflow: overflow,
        maxLines: maxLines ?? 1,
        style: GoogleFonts.poppins(
          height: height,
          color: color,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
