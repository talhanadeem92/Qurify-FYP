import 'package:flutter/material.dart';
import 'package:my_flutter_app/parahbookmark.dart';
import 'package:my_flutter_app/surah_list_page.dart';
import 'package:my_flutter_app/surahbookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedBookmarks = prefs.getStringList('bookmarks');

    if (savedBookmarks != null) {
      setState(() {
        bookmarks =
            savedBookmarks.map((b) => jsonDecode(b) as Map<String, dynamic>).toList();
      });
    }
  }

  Future<void> removeBookmark(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarks.removeAt(index);
    });

    List<String> updatedBookmarks =
        bookmarks.map((b) => jsonEncode(b)).toList();
    await prefs.setStringList('bookmarks', updatedBookmarks);
  }

  void goToVerseLocation(Map<String, dynamic> bookmark) {
    int surahNumber = bookmark['surah'];
    int verseNumber = bookmark['verse'];
    int parahNumber = bookmark['parah'];

    if (surahNumber != 0) {
      // Navigate to Surah Detail Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Surah(surahNumber),
        ),
      );
    } else {
      // Navigate to Parah Detail Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParahDetail(parahNumber),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Verses"),
        backgroundColor: Colors.brown[900],
      ),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks added yet."))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = bookmarks[index];
                return ListTile(
                  title: Text("Surah ${bookmark['surah']}, Ayah ${bookmark['verse']}"),
                  subtitle: Text("Parah ${bookmark['parah']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeBookmark(index),
                  ),
                  onTap: () => goToVerseLocation(bookmark),
                );
              },
            ),
    );
  }
}
