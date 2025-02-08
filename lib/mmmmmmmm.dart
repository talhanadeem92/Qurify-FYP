import 'package:flutter/material.dart';
import 'package:my_flutter_app/homeza.dart';

import 'FAQ.dart';
import 'Helppage.dart';
import 'Qprofile.dart';
import 'Termsandcondition.dart';
import 'aboutpage.dart';
import 'chatbotmesss.dart';
import 'messagescrree.dart';

void main() {
  runApp(QuranApp());
}

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

////////////////////////////////////////////////////
// HomeScreen with Bottom Navigation
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

static final List<Widget> _widgetOptions = <Widget>[
  HomeScreen1(),
  Center(child: Text('Bookmarks', style: TextStyle(fontSize: 24))),
  SettingsScreen(), // Keep SettingsScreen as a tab
  chatbot(),
];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran App'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

////////////////////////////////////////////////////



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar for the profile box
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C5364), Color(0xFF0F2027)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/back1.jpeg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Your Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'your.email@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // SliverList for the body content
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
_buildSettingTile(
  icon: Icons.person,
  title: 'Profile',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileEditPage()),
    );
  },
),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.language,
                        title: 'Change Language',
                        onTap: () {
                          // Handle Change Language
                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.notifications,
                        title: 'Notification Preferences',
                        onTap: () {
                          // Handle Notifications
                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.privacy_tip,
                        title: 'Privacy Settings',
                        onTap: () {
                          // Handle Privacy Settings
                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.info,
                        title: 'About App',
                        onTap: () {
                          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutAppPage()));

                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.help,
                        title: 'Help',
                        onTap: () {
                          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()));

                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.question_answer,
                        title: 'FAQ',
                        onTap: () {
                          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FAQPage()));
                          // Navigate to FAQ Section
                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.description,
                        title: 'Terms and Conditions',
                        onTap: () {
                          Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));

                        },
                      ),
                      SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.logout,
                        title: 'Logout',
                        onTap: () {
                          // Perform Logout
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, // White background for the tile
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.black), // Black icon
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black, // Black text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
