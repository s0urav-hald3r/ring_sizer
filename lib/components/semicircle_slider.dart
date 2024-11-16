import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ring_sizer/config/constants.dart';

class SemiCircleSlider extends StatefulWidget {
  const SemiCircleSlider({
    super.key,
    required this.initialValue,
    required this.divisions,
    required this.onChanged,
  });

  final int initialValue;
  final int divisions;
  final ValueChanged<int> onChanged;

  @override
  State<SemiCircleSlider> createState() => _SemiCircleSliderState();
}

class _SemiCircleSliderState extends State<SemiCircleSlider> {
  late var value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final arcWidth = constraints.maxWidth;
          const height = 0.0;
          final arcRect = Rect.fromLTRB(0, 0, arcWidth, 200);

          return GestureDetector(
            onPanUpdate: (details) {
              final position = details.localPosition - arcRect.center;
              final angle = atan2(position.dy, position.dx);
              final newValue =
                  ((1 - (angle / pi)) * (widget.divisions - 1)).round();
              if (value != newValue &&
                  newValue >= 0 &&
                  newValue < widget.divisions) {
                widget.onChanged(newValue);
                setState(() {
                  value = newValue;
                });
              }
            },
            child: CustomPaint(
              painter: SemiCircleSliderPainter(
                divisions: widget.divisions,
                arcRect: arcRect,
                nubAngle: (1 - (value / (widget.divisions - 1))) * pi,
              ),
              child: const SizedBox(height: height),
            ),
          );
        },
      ),
    );
  }
}

class SemiCircleSliderPainter extends CustomPainter {
  SemiCircleSliderPainter({
    required this.divisions,
    required this.arcRect,
    required this.nubAngle,
  });

  final int divisions;
  final Rect arcRect;
  final double nubAngle;

  static const nubRadius = 25.0;
  static const arcThickness = 2.0;
  static const tickThickness = 1.0;
  static const tickLengthShort = 7.5;
  static const tickLengthLong = 15.0;
  static const tickSpacing = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness
      ..color = secondaryColor;

    // Create a path matching the custom clipper
    Path arcPath = Path();
    arcPath.moveTo(0, arcRect.top);
    arcPath.quadraticBezierTo(
      arcRect.width / 2,
      arcRect.height * 0.5,
      arcRect.width,
      arcRect.top,
    );

    // Draw the bezier arc
    canvas.drawPath(arcPath, arcPaint);

    // Draw division markers
    final Paint tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = tickThickness
      ..color = secondaryColor;

    for (int i = 0; i <= divisions; i++) {
      final t = i / divisions;
      final dx = arcRect.width * t;
      final dy =
          quadraticBezierY(t, arcRect.height * 0, arcRect.height * 0.5, 0);

      final isLongTick = i % 5 == 0;
      final length = isLongTick ? tickLengthLong : tickLengthShort;

      canvas.drawLine(
        Offset(dx, dy - length),
        Offset(dx, dy),
        tickPaint,
      );
    }

    // Draw slider knob
    final t = nubAngle / pi; // Normalized knob angle
    final knobDx = arcRect.left +
        t * (arcRect.width); // Linear interpolation along the x-axis
    final knobDy = quadraticBezierY(
      t,
      arcRect.top, // Start point y
      arcRect.top + arcRect.height * 0.45, // Control point y
      arcRect.top, // End point y
    );

    final knobCenter = Offset(knobDx, knobDy);

    canvas.drawCircle(knobCenter, nubRadius, Paint()..color = secondaryColor);

    // Draw arrows inside the knob
    final TextPainter leftArrow = TextPainter(
      text: const TextSpan(
        text: '‹',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final TextPainter rightArrow = TextPainter(
      text: const TextSpan(
        text: '›',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    leftArrow.paint(
      canvas,
      Offset(
        knobCenter.dx - nubRadius / 1.5,
        knobCenter.dy - leftArrow.height / 2,
      ),
    );
    rightArrow.paint(
      canvas,
      Offset(
        knobCenter.dx + nubRadius / 6,
        knobCenter.dy - rightArrow.height / 2,
      ),
    );
  }

  double quadraticBezierY(double t, double p0, double p1, double p2) {
    return (1 - t) * (1 - t) * p0 + 2 * (1 - t) * t * p1 + t * t * p2;
  }

  @override
  bool shouldRepaint(SemiCircleSliderPainter oldDelegate) {
    return arcRect != oldDelegate.arcRect ||
        nubAngle != oldDelegate.nubAngle ||
        divisions != oldDelegate.divisions;
  }
}
