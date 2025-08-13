import 'dart:async';
import 'package:xpert_test/data/enums/status.dart';
import 'package:xpert_test/models/funding_info_model.dart';

/// Service responsible for fetching funding information.
///
/// Currently returns mock data after a simulated network delay. Implementers
/// can replace the mock generation with real HTTP calls or SDK integrations.
class ApiService {
  // Singleton pattern
  /// Internal singleton instance.
  static final ApiService _instance = ApiService._internal();

  /// Returns the shared [ApiService] instance.
  factory ApiService() => _instance;

  /// Private constructor for the singleton pattern.
  ApiService._internal();

  /// Generates a list of mock [FundingInfoModel] items.
  List<FundingInfoModel> _generateMockData() {
    return List.generate(5, (index) {
      final now = DateTime.now();
      final isFunded = index % 2 == 0;

      return FundingInfoModel(
        id: 'ID${1000 + index}',
        accountName: 'Challenge ${index + 1}',
        active: true,
        balance: 5000.0 + (index * 1000),
        currentPhase: (index % 3) + 1,
        equity: 4000.0 + (index * 1000),
        createdAt: now.subtract(Duration(days: index * 2)),
        numPhases: 3,
        size: 5000,
        fundingStatus: isFunded
            ? FundingStatus.funded
            : FundingStatus.onChallenge,
        isProAccount: index % 3 == 0,
      );
    });
  }

  /// Simulates a network delay to mimic an async API call.
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  /// Returns a list of [FundingInfoModel] entries.
  ///
  /// Throws an [Exception] when fetching fails.
  Future<List<FundingInfoModel>> getFundingInfo() async {
    try {
      // Simulate network delay
      await _simulateNetworkDelay();

      // For now, return mock data
      return _generateMockData();
    } catch (e) {
      throw Exception('Failed to fetch funding info: $e');
    }
  }
}
