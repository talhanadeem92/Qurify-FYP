import 'package:flutter/material.dart';
import 'database_helper.dart';

class VersePage extends StatefulWidget {
  final int surahId;

  VersePage({required this.surahId});

  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  List<Map<String, dynamic>> _verseList = [];

  @override
  void initState() {
    super.initState();
    _loadVerses();
  }

  Future<void> _loadVerses() async {
    List<Map<String, dynamic>> verses = await DatabaseHelper.instance.fetchVerses(widget.surahId);
    setState(() {
      _verseList = verses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Surah Verses")),
      body: ListView.builder(
        itemCount: _verseList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_verseList[index]['text']),
          );
        },
      ),
    );
  }
}
