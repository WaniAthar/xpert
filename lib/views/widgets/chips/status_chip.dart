import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpert_test/data/enums/status.dart';

/// Displays the current [FundingStatus] as a pill-shaped label.
///
/// The visual style (colors and sizes) adapts to [isMobile].
class StatusChip extends StatelessWidget {
  /// Creates a [StatusChip].
  const StatusChip({super.key, this.isMobile = true, required this.status});
  
  /// Whether the chip should render using the mobile scale.
  final bool isMobile;
  /// Funding status to display.
  final FundingStatus status;
  @override
  /// Builds the status chip with appropriate colors for the [status].
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 2.74 : 0.5,
        horizontal: isMobile ? 10.96 : 12.67,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: status == FundingStatus.funded
            ? Color(0xff053321)
            : Color(0xff11285F),
        border: Border.all(
          color: status == FundingStatus.funded
              ? Color(0xff75DFA7)
              : Color(0xff80A4FE),
          width: isMobile ? 1 : 1.37,
        ),
      ),
      child: Text(
        status == FundingStatus.funded ? "Funded" : "On Challenge",
        style: GoogleFonts.interTight(
          fontWeight: FontWeight.w500,
          fontSize: isMobile ? 12 : 15,
          color: status == FundingStatus.funded
              ? Color(0xff75DFA7)
              : Color(0xff80A4FE),
          shadows: [
            Shadow(
              blurRadius: 14,
              color: status == FundingStatus.funded
                  ? Color(0xffABC2FF).withValues(alpha: 0.7)
                  : Color(0xffABC2FF).withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
