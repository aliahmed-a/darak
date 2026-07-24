/// Carries the "appeal this fine" intent from the violation fine detail
/// screen into the create-appeal flow, passed as a `go_router` `extra`.
class ViolationAppealTarget {
  const ViolationAppealTarget({
    required this.violationId,
    required this.label,
    this.violationFineId,
    this.fineAmount,
  });

  final String violationId;
  final String? violationFineId;
  final String label;
  final double? fineAmount;
}
