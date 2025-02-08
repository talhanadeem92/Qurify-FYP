import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/firebase_options.dart'; // Ensure this is correctly set

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
    _timer = Timer.periodic(Duration(seconds: 120), (timer) {
      fetchVerse(); // Fetch a new verse every 2 minutes
    });
  }

  // Fetch one verse from both Arabic and English collections
  Future<void> fetchVerse() async {
    try {
      // Fetch a random Arabic verse
      var arabicSnapshot = await quranArabicCollection.limit(1).get();
      if (arabicSnapshot.docs.isEmpty) return;

      // Get the first Arabic document
      var arabicDoc = arabicSnapshot.docs[0];
      var arabicSurah = arabicDoc['surah'];
      var arabicAyat = arabicDoc['ayat'];

      // Fetch the corresponding English translation
      var englishSnapshot = await quranEnglishCollection
          .where('surah', isEqualTo: arabicSurah)
          .where('ayat', isEqualTo: arabicAyat)
          .limit(1) // Fetch only one matching document
          .get();

      if (englishSnapshot.docs.isEmpty) return;

      // Get the corresponding English document
      var englishDoc = englishSnapshot.docs[0];

      // Update the UI with both Arabic and English verses
      setState(() {
        currentArabicVerse = arabicDoc.data() as Map<String, dynamic>;
        currentEnglishVerse = englishDoc.data() as Map<String, dynamic>;
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
        title: const Text('Firestore Quran Verse'),
      ),
      body: (currentArabicVerse == null || currentEnglishVerse == null)
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
                  const Divider(height: 32, color: Colors.black),
                  // Display English translation details
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
