import 'package:flutter/material.dart';

class DownTriangle extends StatelessWidget {
  final double size;
  final Color color;

  const DownTriangle({
    super.key,
    this.size = 30,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: DownTrianglePainter(color),
    );
  }
}

class DownTrianglePainter extends CustomPainter {
  final Color color;

  DownTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, 0);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
