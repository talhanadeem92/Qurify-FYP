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

    // Base of the Mosque
    paint.color = const Color(0xFFD9C1A5); // Beige color
    final baseRect = Rect.fromLTWH(
        size.width * 0.2, size.height * 0.5, size.width * 0.6, size.height * 0.4);
    canvas.drawRect(baseRect, paint);

    // Dome of the Mosque
    paint.color = const Color(0xFFF8B040); // Golden color
    final domePath = Path();
    domePath.moveTo(size.width * 0.5, size.height * 0.1); // Top of the dome
    domePath.quadraticBezierTo(
        size.width * 0.35, size.height * 0.3, size.width * 0.2, size.height * 0.5); // Left curve
    domePath.quadraticBezierTo(
        size.width * 0.65, size.height * 0.3, size.width * 0.8, size.height * 0.5); // Right curve
    domePath.close();
    canvas.drawPath(domePath, paint);

    // Dome Spire
    paint.color = const Color(0xFFF8B040); // Golden color
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.0), // Topmost sharp point
      Offset(size.width * 0.5, size.height * 0.1), // Base of spire
      paint..strokeWidth = size.width * 0.02,
    );

    // Left Minaret
    paint.color = Colors.white;
    final leftMinaret = Rect.fromLTWH(
        size.width * 0.05, size.height * 0.3, size.width * 0.1, size.height * 0.6);
    canvas.drawRect(leftMinaret, paint);

    // Right Minaret
    final rightMinaret = Rect.fromLTWH(
        size.width * 0.85, size.height * 0.3, size.width * 0.1, size.height * 0.6);
    canvas.drawRect(rightMinaret, paint);

    // Minaret Caps
    paint.color = const Color(0xFFF8B040); // Golden tops
    canvas.drawCircle(
        Offset(size.width * 0.1, size.height * 0.3), size.width * 0.05, paint);
    canvas.drawCircle(
        Offset(size.width * 0.9, size.height * 0.3), size.width * 0.05, paint);

    // Windows
    paint.color = Colors.white;
    final windowPath = Path();

    // Left Window
    windowPath.moveTo(size.width * 0.3, size.height * 0.6);
    windowPath.lineTo(size.width * 0.35, size.height * 0.5);
    windowPath.lineTo(size.width * 0.4, size.height * 0.6);
    windowPath.close();
    canvas.drawPath(windowPath, paint);

    // Middle Window
    windowPath.reset();
    windowPath.moveTo(size.width * 0.45, size.height * 0.6);
    windowPath.lineTo(size.width * 0.5, size.height * 0.5);
    windowPath.lineTo(size.width * 0.55, size.height * 0.6);
    windowPath.close();
    canvas.drawPath(windowPath, paint);

    // Right Window
    windowPath.reset();
    windowPath.moveTo(size.width * 0.6, size.height * 0.6);
    windowPath.lineTo(size.width * 0.65, size.height * 0.5);
    windowPath.lineTo(size.width * 0.7, size.height * 0.6);
    windowPath.close();
    canvas.drawPath(windowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
