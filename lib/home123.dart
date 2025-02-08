import 'package:flutter/material.dart';

void main() {
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

class HomeScreen extends StatelessWidget {
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
                  child: Image.asset(
                    'assets/images/mosque2.gif', // Path to your GIF
                    fit: BoxFit.cover,
                  ),
                ),
                // Semi-transparent overlay for text readability
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
                      Text(
                        'Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Isha: 8:30 PM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Fajr: 5:00 AM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                  // Four Buttons: Tasbih, Qiblah, Quran, Prayer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFeatureButton(
                        context,
                        label: "Tasbih",
                        iconPath: "assets/images/tasbih.png",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TasbihScreen()),
                          );
                        },
                      ),
                      _buildFeatureButton(
                        context,
                        label: "Qiblah",
                        iconPath: "assets/images/qibla.png",
                        onTap: () {
                          // Add navigation logic for Qiblah
                        },
                      ),
                      _buildFeatureButton(
                        context,
                        label: "Quran",
                        iconPath: "assets/images/quran.png",
                        onTap: () {
                          // Add navigation logic for Quran
                        },
                      ),
                      _buildFeatureButton(
                        context,
                        label: "Prayer",
                        iconPath: "assets/images/prayer.png",
                        onTap: () {
                          // Add navigation logic for Prayer
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Allah Name Card
                  SizedBox(
                    height: 250,
                    child: PageView(
                      children: [
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Feature Button Builder
  Widget _buildFeatureButton(BuildContext context,
      {required String label, required String iconPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70, // Slightly larger size for the icon
            width: 70,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white, // White background
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Black text color
            ),
          ),
        ],
      ),
    );
  }

  // Allah Card Builder
  Widget _buildAllahCard({
    required String imagePath,
    required String arabicName,
    required String translation,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              arabicName,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              translation,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder Tasbih Screen
class TasbihScreen extends StatelessWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasbih Screen"),
      ),
      body: const Center(
        child: Text("Tasbih Feature Coming Soon!"),
      ),
    );
  }
}
