import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_direction/qibla_direction.dart';

class QiblaDirectionScreen extends StatefulWidget {
  @override
  _QiblaDirectionScreenState createState() => _QiblaDirectionScreenState();
}

class _QiblaDirectionScreenState extends State<QiblaDirectionScreen> {
  Future<double>? _qiblaDirection;

  @override
  void initState() {
    super.initState();
    _fetchQiblaDirection();
  }

  Future<void> _fetchQiblaDirection() async {
    try {
      // Ensure location permission is granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permission denied");
        }
      }

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Calculate Qibla direction
      double direction = QiblaDirection.qibla(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _qiblaDirection = Future.value(direction);
      });
    } catch (e) {
      print("Error fetching Qibla direction: $e");
      setState(() {
        _qiblaDirection = Future.error("Failed to get Qibla direction");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qibla Direction'),
      ),
      body: Center(
        child: FutureBuilder<double>(
          future: _qiblaDirection,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Qibla Direction: ${snapshot.data?.toStringAsFixed(2)}°',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.navigation,
                    size: 100,
                    color: Colors.blue,
                  ),
                ],
              );
            } else {
              return Text('Unable to fetch Qibla direction');
            }
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QiblaDirectionScreen(),
  ));
}
