import 'package:flutter/material.dart';

/// Full-screen vertical gradient background wrapper.
///
/// Wrap any [child] content to render against the app's dark gradient theme.
class GradientBackground extends StatelessWidget {
  /// Creates a [GradientBackground] for the provided [child].
  const GradientBackground({super.key, required this.child});
  
  /// The widget displayed on top of the gradient background.
  final Widget child;
  @override
  /// Builds the gradient container filling available space.
  Widget build(BuildContext context) {
    return  Container(
      height: double.infinity,
      width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000F33), Color(0xff070707)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      );
  }
}