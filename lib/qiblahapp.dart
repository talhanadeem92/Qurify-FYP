import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QiblahFinder(),
    );
  }
}

class QiblahFinder extends StatefulWidget {
  @override
  _QiblahFinderState createState() => _QiblahFinderState();
}

class _QiblahFinderState extends State<QiblahFinder> {
  GoogleMapController? mapController;
  Position? _currentPosition;
  final LatLng _kaabaLocation = LatLng(21.4225, 39.8262); // Kaaba coordinates
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      _markers.add(
        Marker(
          markerId: MarkerId("user"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "Your Location"),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId("kaaba"),
          position: _kaabaLocation,
          infoWindow: InfoWindow(title: "Kaaba"),
        ),
      );

      _drawQiblahLine(position.latitude, position.longitude);
    });
  }

  void _drawQiblahLine(double lat, double lng) {
    List<LatLng> polylineCoordinates = [
      LatLng(lat, lng),
      _kaabaLocation,
    ];

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId("qiblah"),
          color: Colors.blue,
          width: 5,
          points: polylineCoordinates,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qiblah Finder (Web-Compatible)")),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 10,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
    );
  }
}
