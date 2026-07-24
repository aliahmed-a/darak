import 'poll_option.dart';
import 'poll_status.dart';

class CommunityPoll {
  const CommunityPoll({
    required this.id,
    required this.question,
    required this.status,
    required this.startsAt,
    required this.endsAt,
    required this.allowsMultipleChoices,
    required this.options,
    required this.selectedOptionIds,
    this.description,
  });

  final String id;
  final String question;
  final String? description;
  final PollStatus status;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool allowsMultipleChoices;
  final List<PollOption> options;

  /// The current resident's own vote(s). The backend does not expose vote
  /// tallies/percentages on this endpoint — only what the caller picked.
  final List<String> selectedOptionIds;

  bool get hasVoted => selectedOptionIds.isNotEmpty;

  factory CommunityPoll.fromJson(Map<String, dynamic> json) => CommunityPoll(
        id: json['id'] as String,
        question: json['question'] as String,
        description: json['description'] as String?,
        status: PollStatus.fromInt(json['status'] as int),
        startsAt: DateTime.parse(json['startsAt'] as String),
        endsAt: DateTime.parse(json['endsAt'] as String),
        allowsMultipleChoices: json['allowsMultipleChoices'] as bool,
        options: (json['options'] as List).map((e) => PollOption.fromJson(e as Map<String, dynamic>)).toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder)),
        selectedOptionIds: List<String>.from(json['selectedOptionIds'] as List),
      );
}
