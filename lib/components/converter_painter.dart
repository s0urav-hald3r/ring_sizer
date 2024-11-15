import 'package:flutter/material.dart';
import 'package:ring_sizer/config/constants.dart';

class ConverterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = secondaryColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.15, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ConverterPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ConverterPainter oldDelegate) => false;
}
