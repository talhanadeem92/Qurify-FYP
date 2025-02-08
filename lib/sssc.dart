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
      home: HomeScreen(), // Changed to HomeScreen
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the settings screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailedSettingsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text('Go to Settings'),
        ),
      ),
    );
  }
}

class DetailedSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Settings'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.language, color: Colors.blue),
            title: Text('Change Language'),
            onTap: () {
              // Add Language Change Functionality
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Change Language'),
                  content: Text('Language change feature coming soon!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Notification Preferences'),
            onTap: () {
              // Add Notification Preferences Functionality
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.privacy_tip, color: Colors.blue),
            title: Text('Privacy Settings'),
            onTap: () {
              // Add Privacy Settings Functionality
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('About App'),
            onTap: () {
              // Navigate to About Section
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('About App'),
                  content: Text('Quran App version 1.0.0\nDeveloped by Ahtesham.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
