import 'package:flutter/material.dart';

/// Wraps a [child] with a rounded rectangle gradient stroke.
///
/// Useful for emphasizing containers and controls with a subtle gradient
/// outline. The border is drawn using a [CustomPaint] underlay.
class GradientBorder extends StatelessWidget {
  /// The content inside the bordered container.
  final Widget child;

  /// Width of the gradient stroke.
  final double borderWidth;

  /// Border radius applied to both the stroke and clipping of [child].
  final BorderRadius borderRadius;

  /// Gradient used to paint the stroke.
  final Gradient gradient;

  /// Optional margin around the bordered container.
  final EdgeInsets? margin;
  const GradientBorder({
    super.key,
    this.margin,
    this.borderWidth = 4.0,
    required this.gradient,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
  });

  @override
  /// Builds the container with a [CustomPaint] that draws the border.
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CustomPaint(
        painter: _GradientBorderPainter(
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          gradient: gradient,
        ),
        child: ClipRRect(borderRadius: borderRadius, child: child),
      ),
    );
  }
}

/// Painter that renders a rounded rectangle gradient stroke.
class _GradientBorderPainter extends CustomPainter {
  final double borderWidth;
  final BorderRadius borderRadius;
  final Gradient gradient;

  _GradientBorderPainter({
    required this.borderWidth,
    required this.borderRadius,
    required this.gradient,
  });

  @override
  /// Paints a rounded rectangle stroke using the provided [gradient].
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  /// Repainting is not required for static configuration.
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
