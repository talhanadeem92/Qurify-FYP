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
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile and Settings'),
        // backgroundColor: Colors.blue,
        // centerTitle: true,
        // elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2C5364), Color(0xFF0F2027)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/back1.jpeg'), // Replace with your profile image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'your.email@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Drawer Menu Items
            _buildDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                // Navigate to Home Screen
              },
            ),
            _buildDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                // Navigate to Profile Screen
              },
            ),
            _buildDrawerItem(
              icon: Icons.groups,
              text: 'Communities',
              onTap: () {
                // Navigate to Communities Screen
              },
            ),
            _buildDrawerItem(
              icon: Icons.language,
              text: 'Change Language',
              onTap: () {
                // Open Language Selection
              },
            ),
            _buildDrawerItem(
              icon: Icons.help,
              text: 'Help',
              onTap: () {
                // Navigate to Help Section
              },
            ),
            _buildDrawerItem(
              icon: Icons.question_answer,
              text: 'FAQ',
              onTap: () {
                // Navigate to FAQ Section
              },
            ),
            _buildDrawerItem(
              icon: Icons.description,
              text: 'Terms and Conditions',
              onTap: () {
                // Navigate to Terms and Conditions
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                // Perform Logout
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Settings Screen Content',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
