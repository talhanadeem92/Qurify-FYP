import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; // Import the generated Firebase options

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
  final CollectionReference quranCollection =
      FirebaseFirestore.instance.collection('quran_arabic'); // Firestore collection

  late Timer _timer;
  Map<String, dynamic>? currentVerse;

  @override
  void initState() {
    super.initState();
    fetchVerse(); // Get the initial verse
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      fetchVerse(); // Fetch a new verse every 2 seconds
    });
  }

  // Fetch a single verse from Firestore
  Future<void> fetchVerse() async {
    try {
      var snapshot = await quranCollection.get(); // Get all documents
      if (snapshot.docs.isEmpty) return;

      // Randomly select a verse from the snapshot
      var randomIndex = (snapshot.docs.length * (DateTime.now().second / 60)).floor();
      var doc = snapshot.docs[randomIndex]; // Select a random document based on current time

      setState(() {
        currentVerse = doc.data() as Map<String, dynamic>; // Update the verse
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
      body: currentVerse == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Surah: ${currentVerse!['surah']}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ayat: ${currentVerse!['ayat']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Verse: ${currentVerse!['verse']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
