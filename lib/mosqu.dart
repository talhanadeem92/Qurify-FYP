import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1F4037), // Dark green background
        body: Center(
          child: CustomPaint(
            size: const Size(200, 250), // Canvas size
            painter: MosquePainter(),
          ),
        ),
      ),
    );
  }
}

class MosquePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Mosque base
    paint.color = const Color(0xFFD9C1A5); // Beige color
    final baseRect = Rect.fromLTWH(size.width * 0.2, size.height * 0.5,
        size.width * 0.6, size.height * 0.4);
    canvas.drawRect(baseRect, paint);

    // Dome
    paint.color = const Color(0xFFF8B040); // Golden color
    final domePath = Path();
    domePath.moveTo(size.width * 0.5, size.height * 0.2); // Top of the dome
    domePath.quadraticBezierTo(
        size.width * 0.35, size.height * 0.4, size.width * 0.2, size.height * 0.5);
    domePath.quadraticBezierTo(
        size.width * 0.65, size.height * 0.4, size.width * 0.8, size.height * 0.5);
    domePath.close();
    canvas.drawPath(domePath, paint);

    // Dome tip
    paint.color = const Color(0xFFF8B040);
    final tipRect = Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.15),
        width: size.width * 0.03,
        height: size.height * 0.1);
    canvas.drawRect(tipRect, paint);

    // Minarets (left and right)
    paint.color = Colors.white;
    final leftMinaret = Rect.fromLTWH(
        size.width * 0.05, size.height * 0.3, size.width * 0.1, size.height * 0.6);
    final rightMinaret = Rect.fromLTWH(
        size.width * 0.85, size.height * 0.3, size.width * 0.1, size.height * 0.6);
    canvas.drawRect(leftMinaret, paint);
    canvas.drawRect(rightMinaret, paint);

    // Minaret caps
    paint.color = const Color(0xFFF8B040);
    canvas.drawCircle(
        Offset(size.width * 0.1, size.height * 0.3), size.width * 0.05, paint);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.3), size.width * 0.05, paint);

    // Windows
    paint.color = Colors.white;
    final windowSize = Size(size.width * 0.1, size.height * 0.2);
    final leftWindow = Offset(size.width * 0.3, size.height * 0.6);
    final rightWindow = Offset(size.width * 0.6, size.height * 0.6);
    final middleWindow = Offset(size.width * 0.45, size.height * 0.6);

    canvas.drawRect(leftWindow & windowSize, paint);
    canvas.drawRect(rightWindow & windowSize, paint);
    canvas.drawRect(middleWindow & windowSize, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
