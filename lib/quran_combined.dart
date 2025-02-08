import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'Surah.dart';
import 'ParahDetail.dart';
import 'Surahlist.dart';
import 'Surahlist2.dart';

class QuranListScreen extends StatefulWidget {
  const QuranListScreen({super.key});

  @override
  State<QuranListScreen> createState() => _QuranListScreenState();
}

class _QuranListScreenState extends State<QuranListScreen> {
  bool showSurahList = true; // Toggle state

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: const Text(
      "القرآن الکریم",
      style: TextStyle(fontFamily: 'mushaf', color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Colors.brown[900],
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ),
  body: Column(
    children: [
      // REPLACE THE TOGGLE BUTTONS ROW WITH THIS CONTAINER
      Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.brown[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showSurahList = true;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: showSurahList ? Colors.brown[700] : Colors.brown[900],
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text(
                  "Surah",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              width: 2,
              color: Colors.white,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showSurahList = false;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: !showSurahList ? Colors.brown[700] : Colors.brown[900],
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                child: const Text(
                  "Parah",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),

      // Surah or Parah List based on selection
      Expanded(
        child: showSurahList ? buildSurahList() : buildParahList(),
      ),
    ],
  ),
);
  }

  Widget buildSurahList() {
    return ListView.builder(
      itemCount: quran.totalSurahCount,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.brown[900],
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Surahlist()));
            },
            title: Text(
              quran.getSurahName(index + 1),
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              quran.getSurahNameEnglish(index + 1),
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget buildParahList() {
    return ListView.builder(
      itemCount: 30, // Total Juz (Parah) count
      itemBuilder: (context, index) {
        return Card(
          color: Colors.brown[900],
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParahList()));
            },
            title: Text(
              "پارہ ${index + 1}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}