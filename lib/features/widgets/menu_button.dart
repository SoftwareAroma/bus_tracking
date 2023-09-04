import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Icon icon;
  final double? borderRadius;
  final double? padding;
  final Color? backgroundColor;
  final void Function() onPressed;

  const MenuButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding ?? 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 50.0),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.background,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(
                0.7,
                0.7,
              ),
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
