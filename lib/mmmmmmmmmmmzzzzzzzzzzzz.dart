import 'package:flutter/material.dart';
import 'package:my_flutter_app/parahbookmark.dart';
import 'package:my_flutter_app/surahbookmark.dart';
import 'package:quran/quran.dart' as quran;
import 'bookmark1.dart';
void main() {
  runApp(const QuranHome());
}

class QuranHome extends StatelessWidget {
  const QuranHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran"),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Navigate to the bookmarks page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarksPage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          /// **Parah List Section**
          ExpansionTile(
            title: const Text(
              "پارہ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            children: List.generate(30, (index) {
              return ListTile(
                title: Text("پارہ ${index + 1}"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParahDetail(index + 1),
                    ),
                  );
                },
              );
            }),
          ),

          /// **Surah List Section**
          ExpansionTile(
            title: const Text(
              "سورہ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            children: List.generate(114, (index) {
              return ListTile(
                title: Text(quran.getSurahName(index + 1)),
                subtitle: Text("(${quran.getSurahNameEnglish(index + 1)})"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Surah(index + 1),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
