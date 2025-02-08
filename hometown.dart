import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/firebase_options.dart';
import 'package:my_flutter_app/prayer.dart';
import 'package:my_flutter_app/tasbih.dart';
import 'firebase_options.dart'; // Import the generated Firebase options


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final CollectionReference quranCollection =
      FirebaseFirestore.instance.collection('quran_arabic');
  late Timer _timer;
  Map<String, dynamic>? currentVerse;

  @override
  void initState() {
    super.initState();
    fetchVerse();
    _timer = Timer.periodic(const Duration(seconds: 25), (timer) {
      fetchVerse();
    });
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
    _timer.cancel();
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
                // Fullscreen GIF Background
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
                // Semi-transparent overlay
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
                // Prayer Times Overlay
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
            // Bottom Section with Buttons and Additional Features
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildFeatureButtonsRow(context),
                  const SizedBox(height: 16),
                  _buildPageView(
                    items: [
                      _buildAllahCard(
                        imagePath: "assets/images/sunset.jpg",
                        arabicName: "اللَّهُ",
                        translation: "Allah (The One True God)",
                      ),
                      _buildAllahCard(
                        imagePath: "assets/images/night.jpg",
                        arabicName: "الرَّحْمَٰنُ",
                        translation: "Ar-Rahman (The Most Merciful)",
                      ),
                      _buildAllahCard(
                        imagePath: "assets/images/bird.jpg",
                        arabicName: "الرَّحِيمُ",
                        translation: "Ar-Raheem (The Most Compassionate)",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPageView(
                    items: [
                      _buildProphetCard(
                        imagePath: "assets/images/night.jpg",
                        arabicName: "مُحَمَّدٌ",
                        translation: "Muhammad (The Praised One)",
                      ),
                      _buildProphetCard(
                        imagePath: "assets/images/sunset.jpg",
                        arabicName: "الْأَمِينُ",
                        translation: "Al-Ameen (The Trustworthy)",
                      ),
                      _buildProphetCard(
                        imagePath: "assets/images/bird.jpg",
                        arabicName: "الْرَّحْمَٰنُ",
                        translation: "Ar-Rahman (The Merciful)",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildVerseOfTheDay(),
                ],
              ),
            ),
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

  Widget _buildAllahCard(
      {required String imagePath, required String arabicName, required String translation}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            arabicName,
            style: GoogleFonts.amiri(fontSize: 36, color: Colors.white),
          ),
          Text(
            translation,
            style: GoogleFonts.lora(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProphetCard(
      {required String imagePath, required String arabicName, required String translation}) {
    return _buildAllahCard(
        imagePath: imagePath, arabicName: arabicName, translation: translation);
  }

  Widget _buildVerseOfTheDay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
