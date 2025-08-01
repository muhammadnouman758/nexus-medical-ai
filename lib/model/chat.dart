// lib/models/chat.dart
class ChatMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isUser;
  final MessageStatus status;

  ChatMessage({
    required this.content,
    required this.isUser,
    this.status = MessageStatus.sent,
    String? id,
    DateTime? timestamp,
  })  : id = id ?? "",
        timestamp = timestamp ?? DateTime.now();
}

enum MessageStatus {
  sending,
  sent,
  error,
}