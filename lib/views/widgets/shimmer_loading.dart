import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Rectangular shimmer placeholder used for skeleton loading states.
class ShimmerLoading extends StatelessWidget {
  /// Placeholder width.
  final double width;
  /// Placeholder height.
  final double height;
  /// Corner radius of the rectangle.
  final double borderRadius;
  /// Base color for the shimmer effect.
  final Color? baseColor;
  /// Highlight color for the shimmer effect.
  final Color? highlightColor;
  /// Optional outer margin.
  final EdgeInsetsGeometry? margin;

  const ShimmerLoading({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius = 4.0,
    this.baseColor,
    this.highlightColor,
    this.margin,
  }) : super(key: key);

  @override
  /// Builds the shimmer-animated rectangle.
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[800]!,
        highlightColor: highlightColor ?? Colors.grey[700]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

/// Card-sized shimmer used while loading funding info cards.
class CardShimmer extends StatelessWidget {
  /// Whether to render using mobile spacing/metrics.
  final bool isMobile;

  const CardShimmer({Key? key, this.isMobile = false}) : super(key: key);

  @override
  /// Builds a composite shimmer layout approximating the final card UI.
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withOpacity(0.02),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status chips
          Row(
            children: [
              ShimmerLoading(
                width: 100,
                height: 24,
                borderRadius: 12,
                margin: const EdgeInsets.only(right: 8),
              ),
              const Spacer(),
              ShimmerLoading(
                width: 80,
                height: 24,
                borderRadius: 12,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Equity amount
          ShimmerLoading(
            width: 180,
            height: 36,
            borderRadius: 8,
          ),
          const SizedBox(height: 20),
          // Balance and info row
          Row(
            children: [
              ShimmerLoading(
                width: 80,
                height: 16,
                borderRadius: 4,
              ),
              const Spacer(),
              ShimmerLoading(
                width: 120,
                height: 16,
                borderRadius: 4,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Dotted line
          ShimmerLoading(
            width: double.infinity,
            height: 1,
            borderRadius: 1,
            baseColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.05),
          ),
          const SizedBox(height: 20),
          // Button
          ShimmerLoading(
            width: double.infinity,
            height: 44,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
