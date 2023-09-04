import 'package:flutter/material.dart';

class ContentView extends StatelessWidget {
  final bool isPadded;
  const ContentView({super.key, required this.child, this.isPadded = false});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadded ? const EdgeInsets.all(16.0) : const EdgeInsets.all(0.0),
      child: child,
    );
  }
}
