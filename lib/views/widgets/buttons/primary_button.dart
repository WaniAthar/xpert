import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpert_test/data/icons.dart';
import 'package:xpert_test/views/widgets/gradient_border.dart';

/// Primary action button used across the app.
///
/// Renders an icon and label with a subtle gradient border. Uses a filled
/// background on desktop and a gradient surface on mobile to match design.
class PrimaryButton extends StatelessWidget {
  /// Callback invoked when the button is pressed.
  final VoidCallback onPressed;

  /// Path to the SVG asset rendered as the leading icon.
  final String svgIcon;

  /// Text label for the button.
  final String label;

  /// Whether the button is displayed in a mobile context.
  final bool isMobile;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.svgIcon,
    required this.label,
    this.isMobile = false,
  });

  @override
  /// Builds the button with gradient border and appropriate padding.
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: isMobile
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white, // top
                  Color(0xFFCCDBFF), // bottom
                ],
              )
            : null,
        color: isMobile ? null : Colors.white, // Desktop background
      ),
      child: GradientBorder(
        borderWidth: isMobile ? 1 : 1.14,
        borderRadius: borderRadius,
        gradient: LinearGradient(
          colors: [Colors.white.withValues(alpha: 0), Colors.white],
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              svgIcon,
              height: isMobile ? 14 : 16,
              width: isMobile ? 14 : 16,
            ),
            label: Text(
              label,
              style: GoogleFonts.interTight(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              backgroundColor: isMobile
                  ? Colors.white.withValues(
                      alpha: 0.1,
                    ) // extra overlay for mobile
                  : Colors.white, // desktop plain white
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
