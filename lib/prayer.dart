import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PrayerTimingsScreen1 extends StatefulWidget {
  const PrayerTimingsScreen1({Key? key}) : super(key: key);

  @override
  State<PrayerTimingsScreen1> createState() => _PrayerTimingsScreenState();
}

class _PrayerTimingsScreenState extends State<PrayerTimingsScreen1> {
  DateTime selectedDate = DateTime.now();
  String islamicDate = "Fetching Islamic Date...";
  Map<String, String> prayerTimes = {};
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
    _startAutoUpdate();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchPrayerTimes() async {
    final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    String city = "Karachi";
    String country = "Pakistan";

    final url = Uri.parse(
      'http://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=2&date=$formattedDate',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];
        final hijriDate = data['data']['date']['hijri']['date'];

        setState(() {
          prayerTimes = {
            "Fajr": timings["Fajr"] ?? "--:--",
            "Sunrise": timings["Sunrise"] ?? "--:--",
            "Dhuhr": timings["Dhuhr"] ?? "--:--",
            "Asr": timings["Asr"] ?? "--:--",
            "Maghrib": timings["Maghrib"] ?? "--:--",
            "Isha": timings["Isha"] ?? "--:--",
          };
          islamicDate = hijriDate;
        });
      } else {
        throw Exception("Failed to load prayer times");
      }
    } catch (e) {
      print(e);
    }
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
      _fetchPrayerTimes();
    });
  }

  void _changeDay(bool isNextDay) {
    setState(() {
      selectedDate = isNextDay
          ? selectedDate.add(const Duration(days: 1))
          : selectedDate.subtract(const Duration(days: 1));
    });
    _fetchPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time, color: Colors.blue, size: 30),
            const SizedBox(width: 10),
            const Text(
              "Prayer Timings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Date Selector
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _changeDay(false),
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  Column(
                    children: [
                      Text(
                        DateFormat('EEEE, dd MMMM').format(selectedDate),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        islamicDate,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _changeDay(true),
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Prayer Timings
            Expanded(
              child: prayerTimes.isEmpty
                  ? const Center(child: CircularProgressIndicator(color: Colors.blue))
                  : ListView.builder(
                      itemCount: prayerTimes.length,
                      itemBuilder: (context, index) {
                        String key = prayerTimes.keys.elementAt(index).trim();
                        return _buildPrayerBox(
                          key,
                          prayerTimes[key]!,
                          _getIconForPrayer(key),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create a prayer box
  Widget _buildPrayerBox(String prayerName, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              prayerName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Function to get an icon for each prayer
  IconData _getIconForPrayer(String prayer) {
    switch (prayer) {
      case "Fajr":
        return Icons.wb_sunny_outlined;
      case "Sunrise":
        return Icons.wb_twilight;
      case "Dhuhr":
        return Icons.wb_sunny;
      case "Asr":
        return Icons.cloud;
      case "Maghrib":
        return Icons.nightlight_round;
      case "Isha":
        return Icons.nights_stay;
      default:
        return Icons.access_time;
    }
  }
}
