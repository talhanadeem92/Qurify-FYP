import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_flutter_app/firebase_options.dart';
import 'package:my_flutter_app/db_helper.dart';
import 'package:my_flutter_app/prayer.dart';
import 'package:my_flutter_app/tasbih.dart'; // ✅ Import DB Helper

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('allah_names'); // Open Hive storage
  await DBHelper().initializeDatabase(); // Initialize database

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen1(),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final DBHelper dbHelper = DBHelper();
  String name = "Loading...";
  String transliteration = "";
  String meaning = "";
  String imagePath = "assets/images/sunset.jpg"; // Default image path

  final CollectionReference quranCollection =
      FirebaseFirestore.instance.collection('quran_arabic');

  late Timer _verseTimer;
  late Timer _nameTimer;
  Map<String, dynamic>? currentVerse;
  final List<String> imagePaths = [
    "assets/images/sunset.jpg",
    "assets/images/night.jpg",
    "assets/images/bird.jpg"
  ];

  @override
  void initState() {
    super.initState();
    fetchRandomName();
    fetchVerse();
    _verseTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      fetchVerse();
    });
    _nameTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchRandomName();
    });
  }

  Future<void> fetchRandomName() async {
    var randomName = await dbHelper.getRandomName();
    if (randomName != null) {
      setState(() {
        name = randomName["name"];
        transliteration = randomName["transliteration"];
        meaning = randomName["meaning"];
        imagePath = imagePaths[Random().nextInt(imagePaths.length)];
      });
    } else {
      setState(() {
        name = "No data found!";
      });
    }
  }

  Future<void> fetchVerse() async {
    try {
      var snapshot = await quranCollection.get();
      if (snapshot.docs.isEmpty) return;

      var randomIndex =
          (snapshot.docs.length * (DateTime.now().second / 60)).floor();
      var doc = snapshot.docs[randomIndex];

      setState(() {
        currentVerse = doc.data() as Map<String, dynamic>;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _verseTimer.cancel();
    _nameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Section with Background and Prayer Times
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.8,
                      child: Image.asset(
                        'assets/images/mosquenight.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPrayerTime('Now', 'Isha: 8:30 PM'),
                      const SizedBox(height: 10),
                      _buildPrayerTime('Upcoming', 'Fajr: 5:00 AM'),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildDate('20 January, 2025'),
                      _buildDate('15 رَبِيع ٱلْأَوَّل ١٤٤٦'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureButtonsRow(),
            const SizedBox(height: 16),
            _buildAllahNameSection(),
            const SizedBox(height: 16),
            _buildVerseOfTheDay(),
          ],
        ),
      ),
    );
  }



  Widget _buildPrayerTime(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lobster(color: Colors.white, fontSize: 22),
        ),
        Text(
          time,
          style: GoogleFonts.lobster(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDate(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Cursive',
      ),
    );
  }
  Widget _buildFeatureButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFeatureButton(
          context,
          label: "Tasbih",
          iconPath: "assets/images/tasbih.png",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TasbihScreen()),
            );
          },
        ),
        _buildFeatureButton(
          context,
          label: "Qiblah",
          iconPath: "assets/images/qibla.png",
          onTap: () {},
        ),
        _buildFeatureButton(
          context,
          label: "Quran",
          iconPath: "assets/images/quran.png",
          onTap: () {},
        ),
        _buildFeatureButton(
          context,
          label: "Prayer",
          iconPath: "assets/images/prayer.png",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrayerTimingsScreen1()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureButton(BuildContext context,
      {required String label, required String iconPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView({required List<Widget> items}) {
    return SizedBox(
      height: 250,
      child: PageView(children: items),
    );
  }
    Widget _buildAllahNameSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath), // ✅ Dynamic Image Change
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            transliteration,
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          Text(
            meaning,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  Widget _buildVerseOfTheDay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/verse.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: currentVerse == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verse of the Day",
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  currentVerse!['verse'] ?? '',
                  style: GoogleFonts.amiri(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  currentVerse!['translation'] ?? '',
                  style: GoogleFonts.lora(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
    );
  }
}
