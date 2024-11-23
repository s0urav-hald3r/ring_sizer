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
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final arcWidth = constraints.maxWidth;
          const arcHeight = 200.0; // Height of the bezier curve
          final arcRect = Rect.fromLTRB(0, 0, arcWidth, arcHeight);

          return GestureDetector(
            onPanUpdate: (details) {
              final dx = details.localPosition.dx.clamp(0, arcWidth);
              final t = dx / arcWidth;
              // ignore: unused_local_variable
              final dy = quadraticBezierY(t, arcRect.top, arcRect.height * 0.5,
                  arcRect.top); // Adjusted curve height

              final closestValue = (t * (widget.divisions - 1)).clamp(0.0,
                  widget.divisions.toDouble() - 1); // Map X to slider value

              setState(() {
                value = closestValue;
              });

              widget.onChanged(closestValue.round());
            },
            child: CustomPaint(
              painter: SemiCircleSliderPainter(
                divisions: widget.divisions,
                arcRect: arcRect,
                nubPosition: value / (widget.divisions - 1),
              ),
              child: const SizedBox(height: arcHeight),
            ),
          );
        },
      ),
    );
  }

  double quadraticBezierY(double t, double p0, double p1, double p2) {
    return (1 - t) * (1 - t) * p0 + 2 * (1 - t) * t * p1 + t * t * p2;
  }
}

class SemiCircleSliderPainter extends CustomPainter {
  SemiCircleSliderPainter({
    required this.divisions,
    required this.arcRect,
    required this.nubPosition,
  });

  final int divisions;
  final Rect arcRect;
  final double nubPosition;

  static const double nubRadius = 25.0;
  static const double arcThickness = 2.0;
  static const double tickThickness = 1.0;
  static const double tickLengthShort = 7.5;
  static const double tickLengthLong = 15.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = arcThickness
      ..color = secondaryColor;

    // Create the bezier curve path
    Path arcPath = Path();
    arcPath.moveTo(arcRect.left, arcRect.top);
    arcPath.quadraticBezierTo(
      arcRect.width / 2,
      arcRect.height * 0.5,
      arcRect.width,
      arcRect.top,
    );

    // Draw the bezier curve
    canvas.drawPath(arcPath, arcPaint);

    // Draw tick marks
    final Paint tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = tickThickness
      ..color = secondaryColor;

    for (int i = 0; i <= divisions; i++) {
      final t = i / divisions;
      final dx = arcRect.width * t;
      final dy = quadraticBezierY(
        t,
        arcRect.top,
        arcRect.top + arcRect.height * 0.5,
        arcRect.top,
      );

      final isLongTick = i % 5 == 0;
      final length = isLongTick ? tickLengthLong : tickLengthShort;

      canvas.drawLine(
        Offset(dx, dy - length),
        Offset(dx, dy),
        tickPaint,
      );
    }

    // Draw slider knob
    final knobT = nubPosition.clamp(0.0, 1.0);
    final knobDx = arcRect.width * knobT;
    final knobDy = quadraticBezierY(
      knobT,
      arcRect.top,
      arcRect.top + arcRect.height * 0.5,
      arcRect.top,
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
        nubPosition != oldDelegate.nubPosition;
  }
}
