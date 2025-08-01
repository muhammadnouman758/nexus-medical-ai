// lib/models/bookmark.dart
class Bookmark {
  final String id;
  final String title;
  final String content;
  final DateTime savedAt;
  final String category;

  Bookmark({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();
}