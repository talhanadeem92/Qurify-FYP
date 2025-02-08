import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'data loader.dart';
import 'surah_list_page.dart'; // Your main page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database for Web/Desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await DataLoader.loadData(); // Load JSON into SQLite
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      home: SurahListPage(), // Ensure this page is implemented
    );
  }
}
