import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
  Map<String, dynamic>? prayerTimes;
  String? hijriDate;
  String? gregorianDate;
  String? currentPrayer;
  String? nextPrayer;

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity?city=Islamabad&country=Pakistan&method=2'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          prayerTimes = data['data']['timings'];
          hijriDate = data['data']['date']['hijri']['date'];
          gregorianDate = data['data']['date']['gregorian']['date'];

          // Calculate the next prayer
          currentPrayer = getCurrentPrayer();
          nextPrayer = getNextPrayer(currentPrayer!);
        });
      } else {
        print('Failed to fetch prayer times: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching prayer times: $e');
    }
  }

  String getCurrentPrayer() {
    final now = DateTime.now();
    final prayerTimesList = prayerTimes?.values.toList() ?? [];
    for (int i = 0; i < prayerTimesList.length; i++) {
      final prayerTime = DateTime.parse('${now.year}-${now.month}-${now.day} ${prayerTimesList[i]}');
      if (now.isBefore(prayerTime)) {
        return prayerTimesList[i];
      }
    }
    return prayerTimesList.last; // Return last prayer if current time is after all prayers
  }

  String getNextPrayer(String currentPrayer) {
    final prayerTimesList = prayerTimes?.values.toList() ?? [];
    final index = prayerTimesList.indexOf(currentPrayer);
    if (index < prayerTimesList.length - 1) {
      return prayerTimesList[index + 1];
    }
    return prayerTimesList.first; // Return first prayer if it's the last prayer of the day
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      _buildPrayerTime('Now', currentPrayer ?? 'Loading...'),
                      const SizedBox(height: 10),
                      _buildPrayerTime('Upcoming', nextPrayer ?? 'Loading...'),
                    ],
                  ),
                ),
                // Date Overlay
                Positioned(
                  top: 50,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildDate(gregorianDate ?? 'Loading...'),
                      _buildDate(hijriDate ?? 'Loading...'),
                    ],
                  ),
                ),
              ],
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
          style: GoogleFonts.lobster(
            color: Colors.white,
            fontSize: 22,
          ),
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

  Widget _buildDate(String date) {
    return Text(
      date,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Cursive',
      ),
    );
  }
}
