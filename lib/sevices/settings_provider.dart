// lib/providers/settings_provider.dart
import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  List<String> _bookmarks = [];

  bool get isDarkMode => _isDarkMode;
  List<String> get bookmarks => _bookmarks;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void toggleBookmark(String disease) {
    if (_bookmarks.contains(disease)) {
      _bookmarks.remove(disease);
    } else {
      _bookmarks.add(disease);
    }
    notifyListeners();
  }
}