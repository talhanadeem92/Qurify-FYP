import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('allah_names'); // Open Hive storage
  await DBHelper().initializeDatabase(); // Initialize database
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// 📌 Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBHelper dbHelper = DBHelper();
  String name = "Loading...";
  String transliteration = "";
  String meaning = "";

  @override
  void initState() {
    super.initState();
    fetchRandomName();
  }

  Future<void> fetchRandomName() async {
    var randomName = await dbHelper.getRandomName();
    if (randomName != null) {
      setState(() {
        name = randomName["name"];
        transliteration = randomName["transliteration"];
        meaning = randomName["meaning"];
      });
    } else {
      setState(() {
        name = "No data found!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Allah's Names")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text(transliteration, style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
            Text(meaning, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchRandomName,
              child: Text("Get Random Name"),
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Database Helper using Hive
class DBHelper {
  final Box _box = Hive.box('allah_names');

  Future<void> initializeDatabase() async {
    if (_box.isEmpty) {
      print("⚠ Hive Box is empty! Loading JSON data...");
      await _loadJsonData();
    } else {
      print("✅ Hive Box already contains ${_box.length} records.");
    }
  }

  Future<void> _loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/Jsonfiles/allahsnames.json');
    List<dynamic> jsonData = json.decode(jsonString);

    for (int i = 0; i < jsonData.length; i++) {
      var item = jsonData[i];
      _box.put(i, {
        "name": item["Name"],
        "transliteration": item["Transliteration"],
        "meaning": item["Meaning"]
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
