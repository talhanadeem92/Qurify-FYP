import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
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
                Icons.question_answer,
                size: 80,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Have Questions? Find Your Answers Below',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            _buildFAQItem(
              question: 'What is Qurify?',
              answer:
                  'Qurify is a Quranic chatbot that uses advanced Natural Language Processing (NLP) and Large Language Models (LLMs) to fetch Quranic verses that match users’ queries. It aims to provide accurate and insightful responses based on Islamic teachings.',
            ),
            _buildFAQItem(
              question: 'How does Qurify work?',
              answer:
                  'Qurify processes your queries through an NLP model that understands the context and fetches relevant verses from the Quran. These responses are enhanced by summarizing various scholars’ viewpoints to provide a balanced and comprehensive answer.',
            ),
            _buildFAQItem(
              question: 'Can I trust the answers provided?',
              answer:
                  'Yes, Qurify combines insights from multiple Islamic scholars to ensure the answers are accurate, unbiased, and comprehensive. However, for deeper understanding, consulting a local scholar is recommended.',
            ),
            _buildFAQItem(
              question: 'Does Qurify cater to all schools of thought?',
              answer:
                  'Yes, Qurify strives to include interpretations and opinions from scholars of all major Islamic schools of thought, ensuring a balanced perspective for users.',
            ),
            _buildFAQItem(
              question: 'Can I ask any question to Qurify?',
              answer:
                  'You can ask any question related to the Quran or Islamic teachings. However, queries unrelated to Islam may not yield accurate results.',
            ),
            _buildFAQItem(
              question: 'How are responses validated?',
              answer:
                  'Each response is generated based on Quranic verses, supported by scholarly interpretations, and reviewed to ensure they align with authentic teachings.',
            ),
            _buildFAQItem(
              question: 'Is my data secure when using Qurify?',
              answer:
                  'Yes, Qurify values user privacy. All queries are processed securely, and no personal data is stored or shared with third parties.',
            ),
            _buildFAQItem(
              question: 'Is Qurify free to use?',
              answer:
                  'Currently, Qurify is free for all users. In the future, premium features may be introduced to support the platform’s development.',
            ),
            _buildFAQItem(
              question: 'Can I suggest improvements to Qurify?',
              answer:
                  'Absolutely! We value your feedback. You can suggest improvements through the app’s feedback section or contact us at support@qurify.com.',
            ),
            _buildFAQItem(
              question: 'What if I find an error in the response?',
              answer:
                  'If you believe an error exists, please report it through the app. We will investigate and make necessary corrections promptly.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ExpansionTile(
        leading: Icon(Icons.help, color: Colors.green[700]),
        title: Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
