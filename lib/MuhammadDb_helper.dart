import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class MDBHelper {
  final Box _box = Hive.box('prophet_names');

  Future<void> initializeDatabase() async {
    if (_box.isEmpty) {
      print("⚠ Hive Box is empty! Loading JSON data...");
      await _loadJsonData();
    } else {
      print("✅ Hive Box already contains ${_box.length} records.");
    }
  }

  Future<void> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/Jsonfiles/prophetnames.json');
    List<dynamic> jsonData = json.decode(jsonString);

    for (int i = 0; i < jsonData.length; i++) {
      var item = jsonData[i];
      _box.put(i, {
        "Arabic": item["Arabic"],
        "Name": item["Name"],
        "Meaning": item["Meaning"]
      });
    }
    print("✅ JSON data loaded into Hive!");
  }

  Future<Map<String, dynamic>?> getRandomName() async {
    if (_box.isEmpty) return null;

    List<dynamic> keys = _box.keys.toList();
    int randomKey = keys[Random().nextInt(keys.length)];

    return _box.get(randomKey);
  }
}
