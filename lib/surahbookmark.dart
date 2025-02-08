import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Surah extends StatefulWidget {
  final int indexsurah;
  const Surah(this.indexsurah, {super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  AudioPlayer audioPlayer = AudioPlayer();
  IconData playpauseButton = Icons.play_circle_fill_rounded;
  bool isplaying = true;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> togglebutton() async {
    try {
      final audiourl = await quran.getAudioURLBySurah(widget.indexsurah + 1);
      audioPlayer.setUrl(audiourl);

      if (isplaying) {
        audioPlayer.play();
        setState(() {
          playpauseButton = Icons.pause_circle_rounded;
          isplaying = false;
        });
      } else {
        audioPlayer.pause();
        setState(() {
          playpauseButton = Icons.play_circle_fill_rounded;
          isplaying = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  /// **Function to Add Bookmark**
  Future<void> addBookmark(int verseIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmarks') ?? [];

    Map<String, dynamic> bookmark = {
      "surah": widget.indexsurah + 1,
      "verse": verseIndex + 1,
      "text": quran.getVerse(widget.indexsurah + 1, verseIndex + 1)
    };

    bookmarks.add(jsonEncode(bookmark));
    await prefs.setStringList('bookmarks', bookmarks);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bookmark Added!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          quran.getSurahName(widget.indexsurah + 1),
          style: TextStyle(fontFamily: 'fontqur', color: Colors.white),
        ),
        backgroundColor: Colors.brown[900],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: quran.getVerseCount(widget.indexsurah + 1),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                    quran.getVerse(widget.indexsurah + 1, index + 1, verseEndSymbol: false),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 25, fontFamily: 'fontqur', color: Colors.brown[600]),
                  ),
                  leading: CircleAvatar(
                    child: Text("${index + 1}", style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.brown[900],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.bookmark_add, color: Colors.brown[900]),
                    onPressed: () => addBookmark(index),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
