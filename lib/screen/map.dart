import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world_newest/widget/appbar/bottombar.dart';

class MyMapPage extends StatefulWidget {
  final String title;

  const MyMapPage({Key? key, required this.title}) : super(key: key);

  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  final Completer<GoogleMapController> _mapControllerCompleter = Completer();
  late double _latitude;
  late double _longitude;
  Set<Marker> _markers = {};
  bool _mapReady = false;
  String _locationResult = "";

  @override
  void initState() {
    super.initState();
    _fetchNearestCenters();
  }

  Future<void> _fetchNearestCenters() async {
    final String apiUrl = "https://your-backend-url/api/nearest-centers";
    final double userLatitude = 37.5665; // replace with user's actual latitude
    final double userLongitude = 126.9780; // replace with user's actual longitude

    final response = await http.get(
      Uri.parse('$apiUrl?latitude=$userLatitude&longitude=$userLongitude'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        final centers = data['data'] as List<dynamic>;
        for (var center in centers) {
          _addMarker(center);
        }

        setState(() {
          _locationResult = centers.map((center) =>
          'Name: ${center['name']}, Distance: ${center['distance']} km, Open: ${center['is_open']}, Closing Time: ${center['closing_time']}'
          ).join('\n');
        });

        log('Centers: $_locationResult', name: 'GoogleMap');
      } else {
        setState(() {
          _locationResult = 'Failed to get centers';
        });
        log('Failed to get centers', name: 'GoogleMap');
      }
    } else {
      setState(() {
        _locationResult = 'Failed to get centers';
      });
      log('Failed to get centers', name: 'GoogleMap');
    }
  }

  void _addMarker(Map<String, dynamic> center) async {
    final GoogleMapController controller = await _mapControllerCompleter.future;
    final Marker marker = Marker(
      markerId: MarkerId(center['name']),
      position: LatLng(center['latitude'], center['longitude']),
      infoWindow: InfoWindow(
        title: center['road_address'],
        snippet: '${center['jibun_address']}, Distance: ${center['distance']} km, Open: ${center['is_open']}, Closing Time: ${center['closing_time']}',
      ),
    );

    setState(() {
      _markers.add(marker);
    });

    if (!_mapReady) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(center['latitude'], center['longitude']), 15),
      );
      _mapReady = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapControllerCompleter.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.5665, 126.9780), // Default position to Seoul
                  zoom: 30,
                ),
                markers: _markers,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Text(_locationResult),
            ),
          ],
        ),
        bottomNavigationBar: MyBottomBar(),
      ),
    );
  }
}
