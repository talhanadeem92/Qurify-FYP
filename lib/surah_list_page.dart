import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'verse_page.dart';

class SurahListPage extends StatefulWidget {
  @override
  _SurahListPageState createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  List<Map<String, dynamic>> _surahList = [];

  @override
  void initState() {
    super.initState();
    _loadSurahs();
  }

  Future<void> _loadSurahs() async {
    List<Map<String, dynamic>> surahs = await DatabaseHelper.instance.fetchSurahs();
    setState(() {
      _surahList = surahs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quran Surahs")),
      body: ListView.builder(
        itemCount: _surahList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_surahList[index]['transliteration']),
            subtitle: Text(_surahList[index]['translation']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VersePage(surahId: _surahList[index]['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
