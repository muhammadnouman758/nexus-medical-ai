// lib/repositories/bookmark_repository.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/bookmark.dart';

class BookmarkRepository {
  final SharedPreferences prefs;
  static const _bookmarkKey = 'user_bookmarks';

  BookmarkRepository(this.prefs);

  List<Bookmark> getBookmarks() {
    final jsonString = prefs.getString(_bookmarkKey);
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => Bookmark(
        id: item['id'],
        title: item['title'],
        content: item['content'],
        category: item['category'],
        savedAt: DateTime.parse(item['savedAt']),
      )).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveBookmark(Bookmark bookmark) async {
    final bookmarks = getBookmarks();
    if (bookmarks.any((b) => b.id == bookmark.id)) return;

    final updatedBookmarks = [...bookmarks, bookmark];
    await prefs.setString(_bookmarkKey, jsonEncode(updatedBookmarks.map((b) => {
      'id': b.id,
      'title': b.title,
      'content': b.content,
      'category': b.category,
      'savedAt': b.savedAt.toIso8601String(),
    }).toList()));
  }

  Future<void> removeBookmark(String id) async {
    final bookmarks = getBookmarks();
    final updatedBookmarks = bookmarks.where((b) => b.id != id).toList();
    await prefs.setString(_bookmarkKey, jsonEncode(updatedBookmarks.map((b) => {
      'id': b.id,
      'title': b.title,
      'content': b.content,
      'category': b.category,
      'savedAt': b.savedAt.toIso8601String(),
    }).toList()));
  }
}