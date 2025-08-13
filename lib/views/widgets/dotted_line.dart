import 'package:flutter/material.dart';

/// A horizontal dotted line that supports gradients and rounded dashes.
///
/// Customize dash width, gap, height, radius, and optionally provide a
/// [gradient] or solid [color]. If both are null, a default black color is
/// used.
class GradientDottedLine extends StatelessWidget {
  /// Line thickness.
  final double height;

  /// Width of each dash segment.
  final double dashWidth;

  /// Gap between dash segments.
  final double dashGap;

  /// Optional gradient applied across the entire line.
  final Gradient? gradient;

  /// Optional solid color for the dashes when [gradient] is null.
  final Color? color;

  /// Corner radius applied to each dash segment.
  final double? radius;

  const GradientDottedLine({
    super.key,
    this.height = 1.2,
    this.dashWidth = 3.5,
    this.dashGap = 1.2,
    this.gradient,
    this.color,
    this.radius = 6,
  });

  @override
  /// Lays out and paints the dotted line using a [CustomPaint].
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, height),
          painter: _GradientDottedLinePainter(
            height: height,
            dashWidth: dashWidth,
            dashGap: dashGap,
            gradient: gradient,
            radius: radius!,
            color: color,
          ),
        );
      },
    );
  }
}

/// Painter that draws rounded dash segments with optional gradient.
class _GradientDottedLinePainter extends CustomPainter {
  final double height;
  final double dashWidth;
  final double dashGap;
  final Gradient? gradient;
  final Color? color;
  final double radius;

  _GradientDottedLinePainter({
    required this.height,
    required this.dashWidth,
    required this.dashGap,
    required this.radius,
    this.gradient,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = height
      ..style = PaintingStyle.fill;

    if (gradient != null) {
      paint.shader = gradient!.createShader(
        Rect.fromLTWH(0, 0, size.width, height),
      );
    } else if (color != null) {
      paint.color = color!;
    } else {
      paint.color = Colors.black;
    }

    double startX = 0;
    while (startX < size.width) {
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(startX, 0, dashWidth, height),
        Radius.circular(radius),
      );
      canvas.drawRRect(rrect, paint);
      startX += dashWidth + dashGap;
    }
  }

  @override
  /// This painter is static for given configuration; it doesn't repaint.
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
