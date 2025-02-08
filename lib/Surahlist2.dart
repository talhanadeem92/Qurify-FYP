import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'ParahDetail.dart';  // Import the new screen

class ParahList extends StatefulWidget {
  const ParahList({super.key});

  @override
  State<ParahList> createState() => _ParahListState();
}

class _ParahListState extends State<ParahList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "القرآن الکریم - پارہ",
          style: TextStyle(fontFamily: 'mushaf', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 30, // Total Parahs
        itemBuilder: (context, index) {
          return Card(
            color: Colors.brown[900],
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParahDetail(index + 1),
                  ),
                );
              },
              title: Text(
                "پارہ ${index + 1}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              subtitle: Text(
                "Juz ${index + 1}",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          );
        },
      ),
    );
  }
}
