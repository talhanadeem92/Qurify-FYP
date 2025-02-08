import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

import 'Surah.dart';

class Surahlist extends StatefulWidget {
  const Surahlist({super.key});

  @override
  State<Surahlist> createState() => _SurahlistState();
}

class _SurahlistState extends State<Surahlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "القرآن الکریم ",
          style: TextStyle(fontFamily: 'mushaf', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.brown[900],
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Surah(index),
                  ),
                );
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
        itemCount: quran.totalSurahCount,
      ),
    );
  }
}
