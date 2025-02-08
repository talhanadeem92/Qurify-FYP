import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

// Global list to store bookmarked verses
List<Map<String, String>> bookmarks = [];

void main() {
  runApp(const MyApp());
}

// ✅ Main App Class
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const HomePage(),
    );
  }
}

// ✅ Home Page (Main Menu)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran App"), backgroundColor: Colors.brown[900]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SurahListPage()));
              },
              child: const Text("Read by Surah", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const JuzListPage()));
              },
              child: const Text("Read by Juz (Parah)", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700]),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BookmarkPage()));
              },
              child: const Text("Bookmarks", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Surah List Page
class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Surahs"), backgroundColor: Colors.brown[900]),
      body: ListView.builder(
        itemCount: 114,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(quran.getSurahName(index + 1)),
            subtitle: Text("Ayahs: ${quran.getVerseCount(index + 1)}"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Surah(index)));
            },
          );
        },
      ),
    );
  }
}

// ✅ Juz List Page
class JuzListPage extends StatelessWidget {
  const JuzListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Juz (Parah)"), backgroundColor: Colors.brown[900]),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Juz ${index + 1}"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ParahDetail(index + 1)));
            },
          );
        },
      ),
    );
  }
}

// ✅ Surah Page (Displays Ayahs from the selected Surah)
class Surah extends StatelessWidget {
  final int surahIndex;
  const Surah(this.surahIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quran.getSurahName(surahIndex + 1)), // Get Surah name dynamically
        backgroundColor: Colors.brown[900],
      ),
      body: ListView.builder(
        itemCount: quran.getVerseCount(surahIndex + 1), // Get total verses in Surah
        itemBuilder: (context, index) {
          String verse = quran.getVerse(surahIndex + 1, index + 1); // Get specific verse
          return ListTile(
            title: Text(verse, textAlign: TextAlign.right),
            trailing: IconButton(
              icon: Icon(Icons.bookmark, color: Colors.brown[900]),
              onPressed: () {
                bookmarks.add({
                  'verse': verse,
                  'location': 'Surah ${quran.getSurahName(surahIndex + 1)} - Ayah ${index + 1}'
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verse added to bookmarks!")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ✅ Parah (Juz) Detail Page
class ParahDetail extends StatelessWidget {
  final int parahIndex;
  const ParahDetail(this.parahIndex, {super.key});

  List<Map<String, dynamic>> getVersesInJuz(int juzNumber) {
    List<Map<String, dynamic>> verses = [];
    for (int surah = 1; surah <= 114; surah++) {
      for (int ayah = 1; ayah <= quran.getVerseCount(surah); ayah++) {
        if (quran.getJuzNumber(surah, ayah) == juzNumber) {
          verses.add({
            'verse': quran.getVerse(surah, ayah),
            'surah': quran.getSurahName(surah),
            'ayah': ayah,
          });
        }
      }
    }
    return verses;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> verseList = getVersesInJuz(parahIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text("Juz $parahIndex"),
        backgroundColor: Colors.brown[900],
      ),
      body: ListView.builder(
        itemCount: verseList.length,
        itemBuilder: (context, index) {
          String verse = verseList[index]['verse'];
          String surahName = verseList[index]['surah'];
          int ayahNumber = verseList[index]['ayah'];

          return ListTile(
            title: Text(verse, textAlign: TextAlign.right),
            subtitle: Text("$surahName - Ayah $ayahNumber"),
            trailing: IconButton(
              icon: Icon(Icons.bookmark, color: Colors.brown[900]),
              onPressed: () {
                bookmarks.add({
                  'verse': verse,
                  'location': 'Juz $parahIndex - $surahName Ayah $ayahNumber'
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Verse added to bookmarks!")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ✅ Bookmark Page
class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks"), backgroundColor: Colors.brown[900]),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bookmarks[index]['verse']!),
            subtitle: Text(bookmarks[index]['location']!),
          );
        },
      ),
    );
  }
}
