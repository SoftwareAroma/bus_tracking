import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutlineButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  final Color? color;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  const CustomOutlineButton({
    Key? key,
    this.title,
    this.onPressed,
    this.color,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color ?? BrandColors.kPrimaryColor,
        side: BorderSide(color: color ?? BrandColors.kPrimaryColor),
        textStyle: GoogleFonts.poppins(
          color: color ?? BrandColors.kPrimaryColor,
          letterSpacing: letterSpacing ?? 1.5,
          fontSize: fontSize ?? 16.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onPressed: onPressed ??
          () {
            Navigator.pop(context);
          },
      child: SizedBox(
        height: height ?? 50.0,
        child: Center(
          child: Text(
            title ?? "CLOSE",
            style: GoogleFonts.montserrat(
              fontSize: fontSize ?? 16.0,
              color: color ?? BrandColors.kBrandGreenColor,
            ),
          ),
        ),
      ),
    );
  }
}
