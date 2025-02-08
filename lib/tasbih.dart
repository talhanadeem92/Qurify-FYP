import 'package:flutter/material.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _counter = 0; // Counter for Tasbih

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--; // Prevent negative counts
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tasbih Counter",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white, // White background
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heading
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "All Praise is to Allah",
                style: TextStyle(
                  fontSize: 32, // Increased font size
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold, // Bold font weight
                  color: Colors.black,
                ),
              ),
            ),
            // Counter Display
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 80, // Bigger font size
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minus Button
                GestureDetector(
                  onTap: _decrementCounter,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black, // Black color for - icon
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                // Plus Button
                GestureDetector(
                  onTap: _incrementCounter,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black, // Black color for + icon
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
