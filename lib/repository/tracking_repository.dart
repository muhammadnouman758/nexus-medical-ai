// lib/repositories/tracking_repository.dart
import 'package:shared_preferences/shared_preferences.dart';

import '../model/tracking.dart';

class TrackingRepository {
  final SharedPreferences prefs;

  TrackingRepository(this.prefs);

  // Search history methods
  List<SearchHistoryItem> getSearchHistory() {
    final history = prefs.getStringList('searchHistory') ?? [];
    final frequencyMap = <String, int>{};

    for (final item in history) {
      frequencyMap[item] = (frequencyMap[item] ?? 0) + 1;
    }

    return history.map((query) => SearchHistoryItem(
      query: query,
      timestamp: DateTime.now(),
      frequency: frequencyMap[query] ?? 1,
    )).toList();
  }

  void addSearchQuery(String query) {
    final history = prefs.getStringList('searchHistory') ?? [];
    history.add(query);
    prefs.setStringList('searchHistory', history);
  }

  // Symptom tracking methods
  void addSymptomRecord(SymptomRecord record) {
    final records = getSymptomRecords();
    records.add(record);
    // Save to shared preferences (simplified)
  }

  List<SymptomRecord> getSymptomRecords() {
    // Retrieve from shared preferences
    return [];
  }
}