// lib/models/tracking.dart
class SearchHistoryItem {
  final String query;
  final DateTime timestamp;
  final int frequency;

  SearchHistoryItem({
    required this.query,
    required this.timestamp,
    required this.frequency,
  });
}

class SymptomRecord {
  final String symptom;
  final DateTime date;
  final int severity; // 1-5 scale
  final String notes;

  SymptomRecord({
    required this.symptom,
    required this.date,
    required this.severity,
    this.notes = '',
  });
}