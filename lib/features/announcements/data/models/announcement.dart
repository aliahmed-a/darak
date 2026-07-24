import 'announcement_category.dart';
import 'announcement_priority.dart';

class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.priority,
    required this.createdAt,
    required this.isPinned,
    required this.isRead,
    required this.readCount,
    this.publishedAt,
    this.expiresAt,
  });

  final String id;
  final String title;
  final String body;
  final AnnouncementCategory category;
  final AnnouncementPriority priority;
  final DateTime? publishedAt;
  final DateTime? expiresAt;
  final DateTime createdAt;
  final bool isPinned;
  final bool isRead;
  final int readCount;

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json['id'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        category: AnnouncementCategory.fromInt(json['category'] as int),
        priority: AnnouncementPriority.fromInt(json['priority'] as int),
        publishedAt: json['publishedAt'] == null ? null : DateTime.parse(json['publishedAt'] as String),
        expiresAt: json['expiresAt'] == null ? null : DateTime.parse(json['expiresAt'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        isPinned: json['isPinned'] as bool,
        isRead: json['isRead'] as bool,
        readCount: json['readCount'] as int,
      );
}
