class ResidentUpcomingDueItem {
  const ResidentUpcomingDueItem({
    required this.type,
    required this.targetId,
    required this.label,
    required this.dueDate,
    required this.amount,
    required this.status,
  });

  final String type;
  final String targetId;
  final String label;
  final DateTime dueDate;
  final double amount;
  final String status;

  factory ResidentUpcomingDueItem.fromJson(Map<String, dynamic> json) => ResidentUpcomingDueItem(
        type: json['type'] as String,
        targetId: json['targetId'] as String,
        label: json['label'] as String,
        dueDate: DateTime.parse(json['dueDate'] as String),
        amount: (json['amount'] as num).toDouble(),
        status: json['status'] as String,
      );
}
