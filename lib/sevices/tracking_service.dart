// lib/services/tracking_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class TrackingService {
  final SharedPreferences _prefs;

  TrackingService(this._prefs);

  void trackSearch(String query) {
    final history = _prefs.getStringList('searchHistory') ?? [];
    history.insert(0, query);
    _prefs.setStringList('searchHistory', history.take(20).toList());
  }

  Map<String, int> getSearchFrequency() {
    final history = _prefs.getStringList('searchHistory') ?? [];
    final frequencyMap = <String, int>{};

    for (final item in history) {
      frequencyMap[item] = (frequencyMap[item] ?? 0) + 1;
    }

    return frequencyMap;
  }

  List<String>? getRecommendations() {
    // AI-based recommendation algorithm
  }
}