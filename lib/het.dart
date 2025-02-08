import 'package:flutter/material.dart';

class IslamicAppUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB2DFDB), Color(0xFFE8F5E9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "القرآن",
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 36,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Assalamu Alaikum,\nHow can we assist you today?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Middle Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Ask a Question",
                            icon: Icon(Icons.chat_bubble_outline),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Example Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildActionButton(Icons.bookmark, "Bookmarks"),
                        _buildActionButton(Icons.settings, "Settings"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.teal,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
