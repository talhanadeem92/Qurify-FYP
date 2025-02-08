import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Qurify'),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.info,
                size: 80,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Learn About Qurify',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'What is Qurify?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Qurify is a Quranic chatbot app designed to make the Quran more accessible to everyone. It uses advanced Natural Language Processing (NLP) and Large Language Models (LLMs) to fetch Quranic verses relevant to users’ queries, providing responses that are both accurate and contextually aligned with Islamic teachings.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            _buildFeaturePoint(
              '🟢 Fetches Quranic verses directly based on your query.',
            ),
            _buildFeaturePoint(
              '🟢 Provides detailed explanations for each verse fetched.',
            ),
            _buildFeaturePoint(
              '🟢 Combines verified opinions from various Islamic scholars to offer a comprehensive understanding.',
            ),
            _buildFeaturePoint(
              '🟢 Eliminates the need to rely on unauthenticated sources online.',
            ),
            _buildFeaturePoint(
              '🟢 Makes learning about the Quran easy and accessible from the comfort of your home.',
            ),
            SizedBox(height: 20),
            Text(
              'How Does Qurify Work?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The app leverages state-of-the-art NLP and AI techniques to understand your query, identify its context, and fetch relevant verses from the Quran. Alongside the verses, Qurify provides interpretations and explanations curated by considering views from authentic scholars across Islamic schools of thought.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Why Choose Qurify?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'In a world filled with misinformation, Qurify serves as a trustworthy source for understanding the Quran. Its verified and balanced approach ensures users receive accurate information while respecting the diversity of Islamic thought.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Thank you for choosing Qurify!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 18, color: Colors.green[700])),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
