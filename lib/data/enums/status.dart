/// Represents the funding state of an account.
enum FundingStatus {
  /// Account has completed the challenge and is funded.
  funded,
  /// Account is currently in the evaluation/challenge phase.
  onChallenge
}