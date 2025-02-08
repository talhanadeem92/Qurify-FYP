import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkManager {
  static const String _bookmarkKey = 'bookmarks';

  static Future<List<Map<String, dynamic>>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarksJson = prefs.getString(_bookmarkKey);
    if (bookmarksJson != null) {
      return List<Map<String, dynamic>>.from(json.decode(bookmarksJson));
    }
    return [];
  }

  static Future<void> addBookmark(int surah, int verse, String text) async {
    final bookmarks = await getBookmarks();
    if (!bookmarks.any((b) => b['surah'] == surah && b['verse'] == verse)) {
      bookmarks.add({'surah': surah, 'verse': verse, 'text': text});
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_bookmarkKey, json.encode(bookmarks));
    }
  }

  static Future<void> removeBookmark(int surah, int verse) async {
    final bookmarks = await getBookmarks();
    bookmarks.removeWhere((b) => b['surah'] == surah && b['verse'] == verse);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_bookmarkKey, json.encode(bookmarks));
  }
}

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final data = await BookmarkManager.getBookmarks();
    setState(() {
      bookmarks = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        backgroundColor: Colors.brown[900],
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final bookmark = bookmarks[index];
          return Card(
            child: ListTile(
              title: Text(bookmark['text'], textAlign: TextAlign.right),
              subtitle: Text('Surah ${bookmark['surah']} : Ayah ${bookmark['verse']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await BookmarkManager.removeBookmark(bookmark['surah'], bookmark['verse']);
                  loadBookmarks();
                },
              ),
              onTap: () {
                Navigator.pop(context, bookmark);
              },
            ),
          );
        },
      ),
    );
  }
}
