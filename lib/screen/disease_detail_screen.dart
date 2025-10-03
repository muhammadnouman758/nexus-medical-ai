// lib/screens/disease_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/bookmark.dart';
import '../repository/bookmark_repository.dart';

class DiseaseDetailScreen extends StatefulWidget {
  final String diseaseName;
  final String diseaseInfo;

  const DiseaseDetailScreen({
    Key? key,
    required this.diseaseName,
    required this.diseaseInfo,
  }) : super(key: key);

  @override
  State<DiseaseDetailScreen> createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> {
  bool _isBookmarked = false;
  late BookmarkRepository _bookmarkRepo;

  @override
  void initState() {
    super.initState();
    _bookmarkRepo = context.read<BookmarkRepository>();
    _checkBookmarkStatus();
  }

  void _checkBookmarkStatus() {
    final bookmarks = _bookmarkRepo.getBookmarks();
    _isBookmarked = bookmarks.any((b) => b.id == widget.diseaseName);
    setState(() {});
  }

  void _toggleBookmark() {
    if (_isBookmarked) {
      _bookmarkRepo.removeBookmark(widget.diseaseName);
    } else {
      _bookmarkRepo.saveBookmark(Bookmark(
        id: widget.diseaseName,
        title: widget.diseaseName,
        content: widget.diseaseInfo,
        category: 'Disease',
      ));
    }
    setState(() => _isBookmarked = !_isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diseaseName),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: _toggleBookmark,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          widget.diseaseInfo,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
