import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Manually initialize Firebase for both Android and iOS
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
      FirebaseFirestore.instance.collection('quran_arabic'); // Firestore Arabic collection
  final CollectionReference quranEnglishCollection =
      FirebaseFirestore.instance.collection('quran_english'); // Firestore English collection

  late Timer _timer;
  Map<String, dynamic>? currentArabicVerse;
  Map<String, dynamic>? currentEnglishVerse;

  @override
  void initState() {
    super.initState();
    fetchVerse(); // Get the initial verse
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      fetchVerse(); // Fetch a new verse every 15 seconds
    });
  }

  // Fetch a single verse from Firestore
  Future<void> fetchVerse() async {
    try {
      var arabicSnapshot = await quranArabicCollection.get(); // Get all Arabic documents
      var englishSnapshot = await quranEnglishCollection.get(); // Get all English documents

      if (arabicSnapshot.docs.isEmpty || englishSnapshot.docs.isEmpty) return;

      // Randomly select a verse from the snapshots
      var randomIndexArabic = (arabicSnapshot.docs.length * (DateTime.now().second / 60)).floor();
      var randomIndexEnglish = (englishSnapshot.docs.length * (DateTime.now().second / 60)).floor();

      var arabicDoc = arabicSnapshot.docs[randomIndexArabic]; // Select a random Arabic document
      var englishDoc = englishSnapshot.docs[randomIndexEnglish]; // Select a random English document

      setState(() {
        currentArabicVerse = arabicDoc.data() as Map<String, dynamic>; // Update Arabic verse
        currentEnglishVerse = englishDoc.data() as Map<String, dynamic>; // Update English verse
      });
    } catch (e) {
      print('Error fetching data: $e');
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
                  Text(
                    'Surah (English): ${currentEnglishVerse!['surah']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ayat (English): ${currentEnglishVerse!['ayat']}',
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
