import 'dart:convert';
import 'package:flutter/services.dart';
import 'database_helper.dart';

class DataLoader {
  static Future<void> loadData() async {
    // Load Surah metadata from chapterdetail.json
    String surahJson = await rootBundle.loadString('assets/Jsonfiles/chapterdetail.json');
    List<dynamic> surahList = jsonDecode(surahJson);

    // Format the list into a List<Map<String, dynamic>> if necessary
    List<Map<String, dynamic>> formattedSurahList = surahList.map((item) {
      return {
        'id': item['id'],
        'name': item['name'],
        'transliteration': item['transliteration'],
        'translation': item['translation'],
        'type': item['type'],
        'total_verses': item['total_verses'],
      };
    }).toList();

    // Insert Surah metadata into the database
    await DatabaseHelper.instance.insertSurahMetadata(formattedSurahList);

    // Load verses data from verses.json
    String versesJson = await rootBundle.loadString('assets/Jsonfiles/verses.json');
    Map<String, dynamic> versesMap = jsonDecode(versesJson);

    // Insert verses into the database
    await DatabaseHelper.instance.insertVerses(versesMap);
  }
}
