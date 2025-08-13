import 'package:xpert_test/data/enums/status.dart';

/// Immutable data model representing an account's funding information.
///
/// This model is used by UI widgets such as `MobileCardWidget` and
/// `DesktopCardWidget` to render account details like equity, balance,
/// status, and phase progression.
class FundingInfoModel {
  /// Unique identifier of the account.
  String? id;
  
  /// Date when the account was created or purchased.
  DateTime? createdAt;
  
  /// Current account balance.
  double? balance;
  
  /// Current account equity.
  double? equity;
  
  /// Human-readable account name.
  String? accountName;
  
  /// The current phase number the account is in.
  int? currentPhase; 
  
  /// Funding status derived from the current phase or external data.
  FundingStatus? fundingStatus;
  
  /// Total number of phases in the program.
  int? numPhases;
  
  /// Account size (e.g., initial capital).
  double? size;
  
  /// Whether the account is currently active.
  bool? active;
  
  /// Whether the account has a Pro badge.
  bool? isProAccount;

  /// Creates a new [FundingInfoModel]. All fields are optional to allow
  /// partial population and progressive enhancement.
  FundingInfoModel({
    this.id,
    this.createdAt,
    this.balance,
    this.equity,
    this.accountName,
    this.currentPhase,
    this.fundingStatus,
    this.numPhases,
    this.size,
    this.active,
    this.isProAccount,
  });

  /// Creates a [FundingInfoModel] from a JSON [Map].
  ///
  /// Notes:
  /// - `createdAt` expects an ISO8601 string.
  /// - Numeric fields are safely converted from `num` to `double`.
  /// - `fundingStatus` is inferred from `currentPhase` when present.
  factory FundingInfoModel.fromJson(Map<String, dynamic> json) {
    int? phase = json['currentPhase'] as int?;
    FundingStatus? status;
    if (phase != null) {
      status = (phase >= 0) ? FundingStatus.funded : FundingStatus.onChallenge;
    }

    return FundingInfoModel(
      id: json['id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      balance: (json['balance'] != null)
          ? (json['balance'] as num).toDouble()
          : null,
      equity: (json['equity'] != null)
          ? (json['equity'] as num).toDouble()
          : null,
      accountName: json['accountName'] as String?,
      currentPhase: phase,
      fundingStatus: status,
      numPhases: json['numPhases'] as int?,
      size: (json['size'] != null) ? (json['size'] as num).toDouble() : null,
      active: json['active'] as bool?,
      isProAccount: json['isProAccount'] as bool?,
    );
  }
}
