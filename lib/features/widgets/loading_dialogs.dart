import 'package:bus_tracking/index.dart';
import 'package:flutter/material.dart';

showLoading(BuildContext context, {bool? barrierDismissible}) {
  showDialog(
    barrierDismissible: barrierDismissible ?? false,
    context: context,
    builder: (context) => Center(
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              BrandColors.kColorDarkGreen,
            ),
          ),
        ),
      ),
    ),
  );
}
