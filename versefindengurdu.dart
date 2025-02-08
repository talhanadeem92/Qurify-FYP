import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      home: FirestoreDemo(),
    );
  }
}

class FirestoreDemo extends StatefulWidget {
  @override
  _FirestoreDemoState createState() => _FirestoreDemoState();
}

class _FirestoreDemoState extends State<FirestoreDemo> {
  final CollectionReference quranArabicCollection =
      FirebaseFirestore.instance.collection('quran_arabic'); // Arabic collection
  final CollectionReference quranEnglishCollection =
      FirebaseFirestore.instance.collection('quran_english'); // English collection

  late Timer _timer;
  List<Map<String, dynamic>> arabicVerses = [];
  List<Map<String, dynamic>> englishVerses = [];
  Map<String, dynamic>? currentArabicVerse;
  Map<String, dynamic>? currentEnglishVerse;

  @override
  void initState() {
    super.initState();
    fetchInitialData(); // Fetch data once at the start
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      showRandomVerse(); // Show a new verse every 15 seconds
    });
  }

  // Fetch all verses once and store them locally
  Future<void> fetchInitialData() async {
    try {
      // Fetch all Arabic verses
      var arabicSnapshot = await quranArabicCollection.get();
      arabicVerses = arabicSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // Fetch all English verses
      var englishSnapshot = await quranEnglishCollection.get();
      englishVerses = englishSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      if (arabicVerses.isNotEmpty && englishVerses.isNotEmpty) {
        showRandomVerse(); // Show the first random verse
      }
    } catch (e) {
      print('Error fetching initial data: $e');
    }
  }

  // Select a random verse from the fetched data
  void showRandomVerse() {
    if (arabicVerses.isNotEmpty && englishVerses.isNotEmpty) {
      final random = Random();
      setState(() {
        currentArabicVerse = arabicVerses[random.nextInt(arabicVerses.length)];
        currentEnglishVerse = englishVerses[random.nextInt(englishVerses.length)];
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Quran Verses'),
      ),
      body: currentArabicVerse == null || currentEnglishVerse == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Arabic verse details
                  Text(
                    'Surah (Arabic): ${currentArabicVerse!['surah']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ayat (Arabic): ${currentArabicVerse!['ayat']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Verse (Arabic): ${currentArabicVerse!['verse']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 32),

                  // Display English verse details
                  Text(
                    'Surah (English): ${currentEnglishVerse!['Surah']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Name (English): ${currentEnglishVerse!['Name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ayat (English): ${currentEnglishVerse!['Ayat']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Verse (English): ${currentEnglishVerse!['verse']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
