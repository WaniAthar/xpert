import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpert_test/views/widgets/gradient_border.dart';

/// Badge indicating a Pro account.
///
/// Renders the text "PRO" with a gradient stroke and masked gradient fill.
class ProChip extends StatelessWidget {
  const ProChip({super.key});

  @override
  /// Builds the gradient-stroked PRO badge.
  Widget build(BuildContext context) {
    return GradientBorder(
      borderWidth: 1.14,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff0249FE).withValues(alpha: 0.6),
          Color(0xff80A4FE).withValues(alpha: 0.6),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff0249FE), Color(0xff80A4FE)],
          ).withOpacity(0.3),
        ),
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [Color(0xff5686FE), Color(0xffCCDBFF)],
          ).createShader(bounds),
          child: Text(
            'PRO',
            style: GoogleFonts.interTight(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Color(0xffABC2FF).withValues(alpha: 0.7),
                  blurRadius: 11.42,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
