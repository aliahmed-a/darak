import 'document_approval_status.dart';
import 'document_category.dart';

class DocumentFile {
  const DocumentFile({
    required this.id,
    required this.originalFileName,
    required this.contentType,
    required this.extension,
    required this.sizeInBytes,
    required this.category,
    required this.approvalStatus,
    required this.createdAtUtc,
    this.description,
    this.expiresAtUtc,
  });

  final String id;
  final String originalFileName;
  final String contentType;
  final String extension;
  final int sizeInBytes;
  final DocumentCategory category;
  final DocumentApprovalStatus approvalStatus;
  final String? description;
  final DateTime createdAtUtc;
  final DateTime? expiresAtUtc;

  String get sizeLabel {
    if (sizeInBytes < 1024) return '$sizeInBytes B';
    if (sizeInBytes < 1024 * 1024) return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  factory DocumentFile.fromJson(Map<String, dynamic> json) => DocumentFile(
        id: json['id'] as String,
        originalFileName: json['originalFileName'] as String,
        contentType: json['contentType'] as String,
        extension: json['extension'] as String,
        sizeInBytes: json['sizeInBytes'] as int,
        category: DocumentCategory.fromInt(json['category'] as int),
        approvalStatus: DocumentApprovalStatus.fromInt(json['approvalStatus'] as int),
        description: json['description'] as String?,
        createdAtUtc: DateTime.parse(json['createdAtUtc'] as String),
        expiresAtUtc: json['expiresAtUtc'] == null ? null : DateTime.parse(json['expiresAtUtc'] as String),
      );
}
