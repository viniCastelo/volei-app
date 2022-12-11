import 'package:flutter/material.dart';

class DashedLineVertical extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 16, dashSpace = 20, startY = 15;
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 5;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
