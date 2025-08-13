import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xpert_test/data/icons.dart';
import 'package:xpert_test/models/funding_info_model.dart';
import 'package:xpert_test/views/widgets/buttons/primary_button.dart';
import 'package:xpert_test/views/widgets/chips/phase_chip.dart';
import 'package:xpert_test/views/widgets/chips/pro_chip.dart';
import 'package:xpert_test/views/widgets/chips/status_chip.dart';
import 'package:xpert_test/views/widgets/dotted_line.dart';
import 'package:xpert_test/views/widgets/gradient_border.dart';

/// A responsive card widget optimized for mobile that displays
/// funding account details such as status, phase progress, and key metrics.
class MobileCardWidget extends StatelessWidget {
  /// Constructor for [MobileCardWidget].
  const MobileCardWidget({super.key, required this.fundingInfoModel});

  /// The data model containing funding-related information used to
  /// populate this card's UI.
  final FundingInfoModel fundingInfoModel;

  /// Indicates this widget renders in a mobile layout.
  final isMobile = true;

  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      gradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.19), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      borderWidth: 1.17,
      child: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 60,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 300,
                        spreadRadius: 80,
                        color: Color(0xff1456FE),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 30,
                  color: Colors.black.withValues(alpha: 0.25),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusChip(
                      status: fundingInfoModel.fundingStatus!,
                      isMobile: isMobile,
                    ),
                    SizedBox(width: 6),
                    PhaseChip(
                      isMobile: isMobile,
                      phaseNumber:
                          fundingInfoModel.currentPhase! <
                              fundingInfoModel.numPhases!
                          ? fundingInfoModel.currentPhase!
                          : null,
                      isMasterAccount:
                          fundingInfoModel.currentPhase! ==
                          fundingInfoModel.numPhases!,
                      isActive:
                          fundingInfoModel.currentPhase! <=
                          fundingInfoModel.numPhases!,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fundingInfoModel.accountName!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 11.42),
                    Visibility(
                      visible: fundingInfoModel.isProAccount!,
                      child: ProChip(),
                    ),
                  ],
                ),
                SizedBox(height: 9.5),
                Text(
                  "\$${NumberFormat('#,##0.##').format(fundingInfoModel.equity!)}",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                _balanceData(
                  toolTip: "Balance of the funding account",
                  onTap: () {},
                  key: "Balance",
                  value:
                      "\$${NumberFormat('#,##0.##').format(fundingInfoModel.balance!)}",
                ),
                SizedBox(height: 8),
                _balanceData(
                  toolTip: "ID of the funding account",
                  key: "ID",
                  value: fundingInfoModel.id!,
                  showInfoIcon: true,
                  onTap: () {},
                ),
                SizedBox(height: 8),
                _balanceData(
                  toolTip: "Bought Date of the funding account",
                  key: "Bought",
                  value: DateFormat(
                    'MMM d, yyyy',
                  ).format(fundingInfoModel.createdAt!),
                  showInfoIcon: true,
                  onTap: () {},
                ),
                SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {},
                  svgIcon: SVGIcons.svgDashboard,
                  label: "Dashboard",
                  isMobile: isMobile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceData({
    required String key,
    required String value,
    required String toolTip,
    bool showInfoIcon = false,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        Text(
          '$key :',
          style: GoogleFonts.interTight(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.white,
          ),
        ),

        if (showInfoIcon)
          Tooltip(
            message: toolTip,
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A responsive card widget optimized for desktop that displays
/// funding account details such as status, phase progress, and key metrics.
class DesktopCardWidget extends StatelessWidget {
  /// Constructor for [DesktopCardWidget].
  const DesktopCardWidget({super.key, required this.fundingInfoModel});

  /// Whether to render using mobile spacing/metrics.
  final isMobile = false;

  /// The data model containing funding-related information used to
  /// display the card.
  final FundingInfoModel fundingInfoModel;

  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      gradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.19), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      borderWidth: 1.17,
      child: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 350,
                        spreadRadius: 80,
                        color: Color(0xff1456FE),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 30,
                  color: Colors.black.withValues(alpha: 0.25),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ).copyWith(top: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        fundingInfoModel.accountName!,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.27,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 11.42),
                      Visibility(
                        visible: fundingInfoModel.isProAccount!,
                        child: ProChip(),
                      ),
                      Spacer(),
                      StatusChip(
                        status: fundingInfoModel.fundingStatus!,
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 9.5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "\$${NumberFormat('#,##0.##').format(fundingInfoModel.equity!)}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 9),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        "Balance :",
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "\$${NumberFormat('#,##0.##').format(fundingInfoModel.balance!)}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 9),
                      CircleAvatar(
                        radius: 4.57 / 2,
                        foregroundColor: Colors.white.withValues(alpha: 0.8),
                      ),
                      SizedBox(width: 9),
                      Text.rich(
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        TextSpan(
                          children: [
                            TextSpan(text: "Bought "),
                            TextSpan(
                              text: DateFormat(
                                'MMM d, yyyy',
                              ).format(fundingInfoModel.createdAt!),
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                color: Colors.white.withValues(alpha: 0.9),
                                decorationColor: Colors.white.withValues(
                                  alpha: 0.9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 9),
                      GestureDetector(
                        onTap: () {},
                        child: Tooltip(
                          message: "Bought Date of the funding account",
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      SizedBox(width: 9),
                      CircleAvatar(
                        radius: 4.57 / 2,
                        foregroundColor: Colors.white.withValues(alpha: 0.8),
                      ),
                      SizedBox(width: 9),

                      Text(
                        "ID: ${fundingInfoModel.id!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                      SizedBox(width: 9),
                      GestureDetector(
                        onTap: () {},
                        child: Tooltip(
                          message: "ID of the funding account",
                          child: Icon(
                            Icons.info_outline_rounded,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 11.42),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1.14,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        child: GradientDottedLine(
                          height: 1.14,
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [Colors.white, Colors.transparent],
                          ).withOpacity(0.2),
                        ),
                      ),
                      _buildDotsAndPhaseChips(),
                      SizedBox(
                        width: 25,
                        child: GradientDottedLine(
                          height: 1.14,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.white, Colors.transparent],
                          ).withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                  ).copyWith(bottom: 16),
                  child: PrimaryButton(
                    onPressed: () {},
                    svgIcon: SVGIcons.svgDashboard,
                    label: "Dashboard",
                    isMobile: isMobile,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildDotsAndPhaseChips() {
    List<Widget> widgets = [];
    for (int i = 1; i < fundingInfoModel.numPhases!; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 3.0),
          child: PhaseChip(
            isActive: i <= fundingInfoModel.currentPhase!,
            isMobile: isMobile,
            phaseNumber: i,
          ),
        ),
      );
      if (i != fundingInfoModel.numPhases!) {
        widgets.add(
          SizedBox(
            width: 94,
            child: GradientDottedLine(
              color: i <= fundingInfoModel.currentPhase!
                  ? null
                  : Colors.white.withValues(alpha: 0.2),
              height: 1.14,
              gradient: i <= fundingInfoModel.currentPhase!
                  ? LinearGradient(
                      stops: [0.0, 0.2, 0.8, 1.0],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Color(0xff2C67FE),
                        Color(0xff2C67FE).withValues(alpha: 0.5),
                        Color(0xff2C67FE).withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    )
                  : null,
            ),
          ),
        );
      }
    }
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: PhaseChip(
          isActive: fundingInfoModel.currentPhase == fundingInfoModel.numPhases,
          isMobile: isMobile,
          isMasterAccount: true,
        ),
      ),
    );
    return Row(children: widgets);
  }
}
