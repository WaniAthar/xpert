import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpert_test/data/icons.dart';
import 'package:xpert_test/views/widgets/gradient_border.dart';

/// Chip UI representing the account's phase or master account state.
///
/// When [isActive] is true, the chip is highlighted with a gradient border.
/// Use [isMasterAccount] to render the master account label; otherwise
/// provide a [phaseNumber] to show the evaluation phase.
class PhaseChip extends StatelessWidget {
  /// Constructor for [PhaseChip].
  const PhaseChip({
    super.key,
    this.isMobile = false,
    this.phaseNumber,
    this.isMasterAccount = false,
    this.isActive = false,
  });

  /// Whether this chip is displayed on mobile.
  final bool isMobile;

  /// Whether this chip is visually active/highlighted.
  final bool isActive;

  /// Whether this represents the master account (no phase number shown).
  final bool isMasterAccount;

  /// The evaluation phase number to display when not a master account.
  final int? phaseNumber;

  /// Returns the localized name for the current phase variant.
  String _getPhaseName() {
    assert(phaseNumber != 0, "phaseNumber cannot be '0'");
    assert(
      !(phaseNumber != null && isMasterAccount),
      "Both 'phaseNumber' and 'isMasterAccount' cannot be set",
    );

    if (isMasterAccount) {
      return "Master Account";
    } else {
      return "Evaluation $phaseNumber";
    }
  }

  /// The inner content of the chip used both for active and inactive states.
  Widget get innerChild => Container(
    padding: isMobile
        ? EdgeInsets.symmetric(horizontal: 8, vertical: 4)
        : EdgeInsets.symmetric(horizontal: 13.7, vertical: 4.57),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(1000),
      color: isActive ? null : Colors.white.withValues(alpha: 0.1),
      border: isActive
          ? null
          : Border.all(color: Colors.white.withValues(alpha: 0.1)),
      gradient: isActive
          ? LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0, 0.59],
              colors: [
                Color(0xff5865F2).withValues(alpha: 0.7),
                Color(0xff5865F2).withValues(alpha: 0.28),
              ],
            )
          : null,
    ),
    child: Row(
      children: [
        SvgPicture.asset(
          isMasterAccount ? SVGIcons.svgLockOpen : SVGIcons.svgBarGraph,
          height: isMobile ? 13 : 14,
          width: isMobile ? 13 : 14,
          color: Colors.white,
        ),
        SizedBox(width: isMobile ? 6 : 6.85),
        Text(
          _getPhaseName(),
          style: GoogleFonts.inter(
            fontSize: isMobile ? 12 : 13.7,
            fontWeight: isActive ? FontWeight.normal : FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  @override
  /// Builds the chip with an optional gradient border if [isActive] is true.
  Widget build(BuildContext context) {
    return isActive
        ? GradientBorder(
            borderWidth: isMobile ? 1 : 1.14,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              stops: [0, 0.59, 1],
              colors: [
                Color(0xff5865F2),
                Color(0xff5865F2).withValues(alpha: 0.2),
                Color(0xff5865F2).withValues(alpha: 0.2),
              ],
            ),
            child: innerChild,
          )
        : innerChild;
  }
}
