class PollOption {
  const PollOption({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  final String id;
  final String text;
  final int displayOrder;

  factory PollOption.fromJson(Map<String, dynamic> json) => PollOption(
        id: json['id'] as String,
        text: json['text'] as String,
        displayOrder: json['displayOrder'] as int,
      );
}
