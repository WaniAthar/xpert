import 'package:flutter/material.dart';
import 'package:xpert_test/models/funding_info_model.dart';
import 'package:xpert_test/services/api_service.dart';

/// Controller for the home screen, responsible for loading and exposing
/// funding information to the UI.
///
/// It exposes loading state, the data list, and any error message via getters
/// suitable for consumption by `Provider`/`Consumer` widgets.
class HomeScreenController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  bool _isLoading = true;
  List<FundingInfoModel> _fundingInfoList = [];
  String? _error;

  // Getters
  /// Whether data is currently being loaded.
  bool get isLoading => _isLoading;
  
  /// The list of funding info items for display.
  List<FundingInfoModel> get fundingInfoList => _fundingInfoList;
  
  /// Optional error message when loading fails.
  String? get error => _error;

  /// Initializes the controller and triggers the initial load.
  HomeScreenController() {
    _loadFundingInfo();
  }

  /// Loads funding info from the [ApiService].
  ///
  /// Notifies listeners on state changes and captures errors into [error].
  Future<void> _loadFundingInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _apiService.getFundingInfo();
      _fundingInfoList = data;
      _error = null;
    } catch (e) {
      _error = 'Failed to load data: $e';
      debugPrint('Error loading funding info: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Forces a refresh by reloading funding info.
  Future<void> refresh() async {
    await _loadFundingInfo();
  }
}