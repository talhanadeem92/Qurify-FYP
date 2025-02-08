import 'package:flutter/material.dart';

class QuranApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quran App"),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(child: buildSurahList(context)),
          Expanded(child: buildParahList(context)),
        ],
      ),
    );
  }
}

Widget buildSurahList(BuildContext context) {
  return ListView.builder(
    itemCount: 114,
    itemBuilder: (context, index) {
      return Card(
        color: Colors.brown[900],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahScreen(),
              ),
            );
          },
          title: Text(
            "Surah ${index + 1}",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}

Widget buildParahList(BuildContext context) {
  return ListView.builder(
    itemCount: 30,
    itemBuilder: (context, index) {
      return Card(
        color: Colors.brown[900],
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParahScreen(),
              ),
            );
          },
          title: Text(
            "پارہ ${index + 1}",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}

class SurahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surah Reading"),
        backgroundColor: Colors.brown[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(child: Text("Surah Content Here")),
    );
  }
}

class ParahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parah Reading"),
        backgroundColor: Colors.brown[800],
      ),
      body: Center(child: Text("Parah Content Here")),
    );
  }
}

void main() => runApp(QuranApp());