import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpert_test/controllers/home_screen_controller.dart';
import 'package:xpert_test/views/widgets/card_widget.dart';
import 'package:xpert_test/views/widgets/gradient_background.dart';
import 'package:xpert_test/views/widgets/shimmer_loading.dart';

/// Entry view showing a list of funding accounts with responsive layouts.
///
/// Uses [Provider] to supply a [HomeScreenController] and switches between
/// mobile and desktop presentations.
class HomeScreen extends StatelessWidget {
  /// Constructor for [HomeScreen].
  const HomeScreen({super.key});

  @override
  /// Builds the screen and wires up state management with [ChangeNotifierProvider].
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenController(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Consumer<HomeScreenController>(
        builder: (context, controller, _) {
          // Show error message if any
          if (controller.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(controller.error!)));
            });
          }

          return GradientBackground(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Mobile layout (width < 800)
                if (constraints.maxWidth < 800) {
                  return _buildMobileLayout(controller);
                }
                // Tablet and Desktop layout (width >= 800)
                else {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: _buildDesktopLayout(controller),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  /// Mobile layout that renders a vertical list of cards.
  Widget _buildMobileLayout(HomeScreenController controller) {
    if (controller.isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: 3, // Show 3 shimmer cards
        itemBuilder: (context, index) => const CardShimmer(isMobile: true),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: controller.fundingInfoList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: MobileCardWidget(
          fundingInfoModel: controller.fundingInfoList[index],
        ),
      ),
    );
  }

  /// Desktop layout that renders cards in a centered wrap with constraints.
  Widget _buildDesktopLayout(HomeScreenController controller) {
    if (controller.isLoading) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: List.generate(5, (index) => const CardShimmer()),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Wrap(
          runSpacing: 0,
          spacing: 0,
          children: controller.fundingInfoList.map((fundingInfo) {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: DesktopCardWidget(fundingInfoModel: fundingInfo),
            );
          }).toList(),
        ),
      ),
    );
  }
}
