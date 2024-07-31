import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  final Set<Marker> _markers = {};
  bool _mapReady = false;
  String _locationResult = "";

  @override
  void initState() {
    super.initState();
    _fetchNearestCenters();
  }

  Future<void> _fetchNearestCenters() async {
    // Dummy data
    const String response = '''
    {
      "status": "success",
      "data": [
        {
          "name": "상담센터 1",
          "road_address": "서울특별시 중구 을지로 281",
          "jibun_address": "서울특별시 중구 을지로7가 143",
          "latitude": 37.5675466,
          "longitude": 127.0099323,
          "distance": 1.2,
          "is_open": true,
          "closing_time": "18:00"
        },
        {
          "name": "상담센터 2",
          "road_address": "서울특별시 중구 을지로 282",
          "jibun_address": "서울특별시 중구 을지로7가 144",
          "latitude": 37.5675467,
          "longitude": 127.0099324,
          "distance": 2.5,
          "is_open": false,
          "closing_time": "18:00"
        },
        {
          "name": "상담센터 3",
          "road_address": "서울특별시 중구 을지로 283",
          "jibun_address": "서울특별시 중구 을지로7가 145",
          "latitude": 37.5675468,
          "longitude": 127.0099325,
          "distance": 3.0,
          "is_open": true,
          "closing_time": "18:00"
        }
      ]
    }
    ''';

    final data = jsonDecode(response);
    if (data['status'] == 'success') {
      final centers = data['data'] as List<dynamic>;
      for (var center in centers) {
        _addMarker(center);
      }

      setState(() {
        _locationResult = centers
            .map((center) =>
                'Name: ${center['name']}, Distance: ${center['distance']} km, Open: ${center['is_open']}, Closing Time: ${center['closing_time']}')
            .join('\n');
      });

      log('Centers: $_locationResult', name: 'GoogleMap');
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
        snippet:
            '${center['jibun_address']}, Distance: ${center['distance']} km, Open: ${center['is_open']}, Closing Time: ${center['closing_time']}',
      ),
    );

    setState(() {
      _markers.add(marker);
    });

    if (!_mapReady) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(
            LatLng(center['latitude'], center['longitude']), 15),
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
                initialCameraPosition: const CameraPosition(
                  target:
                      LatLng(37.5665, 126.9780), // Default position to Seoul
                  zoom: 15,
                ),
                markers: _markers,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(_locationResult),
            ),
          ],
        ),
        // bottomNavigationBar: MyBottomBar(),
      ),
    );
  }
}
