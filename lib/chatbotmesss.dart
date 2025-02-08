import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

// Replace this with your Google Generative AI API key
const String apiKey = "AIzaSyChe4CaSqLgB58KJ4RpQah6yL7KUei7PLU";
void main() async {

  runApp(const chatbot());
}

class chatbot extends StatelessWidget {
  const chatbot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _bot = const types.User(id: 'bot');

  // Function to add a message to the chat UI
  void _addMessage(String text, types.User sender) {
    final message = types.TextMessage(
      author: sender,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toString(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  // Function to fetch AI response using Google Generative AI
  Future<String> _getAIResponse(String userInput) async {
    const String apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent";

    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userInput}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String responseText =
            data['candidates'][0]['content']['parts'][0]['text'];
        return responseText;
      } else {
        return "Sorry, I couldn't process that. [Error: ${response.statusCode}]";
      }
    } catch (e) {
      return "An error occurred: $e";
    }
  }

  // Handles when the user sends a message
  Future<void> _handleSendPressed(types.PartialText message) async {
    // Add the user's message to the chat
    _addMessage(message.text, _user);

    // Show a loading message from the bot
    const loadingMessage = "Thinking...";
    final botLoadingMessage = types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'loading',
      text: loadingMessage,
    );

    setState(() {
      _messages.insert(0, botLoadingMessage);
    });

    // Fetch response from the AI service
    final aiResponse = await _getAIResponse(message.text);

    // Remove the loading message and add the AI response
    setState(() {
      _messages.removeWhere((msg) => msg.id == 'loading');
      _addMessage(aiResponse, _bot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chatbot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
