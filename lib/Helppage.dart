import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.help_outline,
                size: 80,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'How can we assist you?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ),
            SizedBox(height: 30),
            _buildHelpTile(
              icon: Icons.question_answer,
              title: 'What is Qurify?',
              description:
                  'Learn more about Qurify, how it works, and what you can ask the Quran chatbot.',
              onTap: () {
                _showHelpDialog(
                  context,
                  'What is Qurify?',
                  'Qurify is a Quranic chatbot designed to help you ask questions and receive responses based on the Quran\'s teachings. Simply type your question and get insights!',
                );
              },
            ),
            SizedBox(height: 20),
            _buildHelpTile(
              icon: Icons.chat,
              title: 'How to use the chatbot?',
              description:
                  'Step-by-step guide to interact with the chatbot and get the most out of Qurify.',
              onTap: () {
                _showHelpDialog(
                  context,
                  'How to use the chatbot?',
                  '1. Open the chatbot from the Messages section.\n'
                  '2. Type your question in the input box.\n'
                  '3. Click on the Send button to get a response.\n'
                  '4. You can ask follow-up questions for clarity.',
                );
              },
            ),
            SizedBox(height: 20),
            _buildHelpTile(
              icon: Icons.security,
              title: 'Is my data secure?',
              description:
                  'Understand how we handle and protect your personal data and interactions.',
              onTap: () {
                _showHelpDialog(
                  context,
                  'Is my data secure?',
                  'We take data security seriously. Your interactions with Qurify are encrypted, and no personal data is shared with third parties.',
                );
              },
            ),
            SizedBox(height: 20),
            _buildHelpTile(
              icon: Icons.bug_report,
              title: 'Report an issue',
              description:
                  'Encountered a problem? Let us know so we can resolve it for you.',
              onTap: () {
                _showHelpDialog(
                  context,
                  'Report an issue',
                  'Please email us at support@qurify.com or use the feedback section in the app to report issues.',
                );
              },
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Back to Home',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpTile({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.green[700]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
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

  void _showHelpDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: Colors.green[700]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
