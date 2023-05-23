import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset p1;
  final Offset p2;

  LinePainter({required this.p1, required this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.p1 != p1 || oldDelegate.p2 != p2;
  }
}
