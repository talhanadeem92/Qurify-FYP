import 'package:flutter/material.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quran App',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C5364), Color(0xFF0F2027)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // App Title
                Text(
                  "Quran Kareem",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                Text(
                  "Explore the beauty of the Quran",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 40),
                // Image or Illustration
                Center(
                  child: Image.asset(
                    'assets/images/back1.jpeg', // Replace with your image asset
                    height: 200,
                  ),
                ),
                SizedBox(height: 40),
                // Buttons
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOptionCard(
                          title: "Read Quran",
                          subtitle: "Dive into the Holy Book",
                          icon: Icons.book,
                          onTap: () {
                            // Navigate to Read Quran Page
                          },
                        ),
                        _buildOptionCard(
                          title: "Bookmarks",
                          subtitle: "View your saved Ayahs",
                          icon: Icons.bookmark,
                          onTap: () {
                            // Navigate to Bookmarks Page
                          },
                        ),
                        _buildOptionCard(
                          title: "Daily Reminders",
                          subtitle: "Set your Quran goals",
                          icon: Icons.alarm,
                          onTap: () {
                            // Navigate to Reminders Page
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Developed with ❤️ by Your Name",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green.shade200,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }
}
