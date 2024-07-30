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
  String _address = "서울 중구 을지로 281";
  String _locationResult = "";
  late double _latitude;
  late double _longitude;
  late String _roadAddress;
  late String _jibunAddress;
  Set<Marker> _markers = {};
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _fetchCoordinates();
  }

  Future<void> _fetchCoordinates() async {
    final String apiUrl = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode";
    final response = await http.get(
      Uri.parse('$apiUrl?query=${Uri.encodeComponent(_address)}'),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': '0y26j6fv1v',
        'X-NCP-APIGW-API-KEY': 'ok8B9H8mtT7igIO2Vl786Q4qX4smdpKownLGUnKf',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final addresses = data['addresses'] as List<dynamic>;

      if (addresses.isNotEmpty) {
        final address = addresses[0];
        setState(() {
          _roadAddress = address['roadAddress'] ?? 'No Road Address';
          _jibunAddress = address['jibunAddress'] ?? 'No Jibun Address';
          _latitude = double.parse(address['y']);
          _longitude = double.parse(address['x']);
          _locationResult = 'Road Address: $_roadAddress, Jibun Address: $_jibunAddress, Latitude: $_latitude, Longitude: $_longitude';
        });

        log('Coordinates: $_locationResult', name: 'GoogleMap');

        // Call _addMarkerToMap() after fetching the coordinates
        if (_mapReady) {
          _addMarkerToMap();
        }
      } else {
        setState(() {
          _locationResult = 'No address found';
        });
        log('No address found', name: 'GoogleMap');
      }
    } else {
      setState(() {
        _locationResult = 'Failed to get coordinates';
      });
      log('Failed to get coordinates', name: 'GoogleMap');
    }
  }

  Future<void> _addMarkerToMap() async {
    final GoogleMapController controller = await _mapControllerCompleter.future;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('address_marker'),
          position: LatLng(_latitude, _longitude),
          infoWindow: InfoWindow(
            title: _roadAddress,
            snippet: _jibunAddress,
          ),
        ),
      );
    });

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(_latitude, _longitude), 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapControllerCompleter.complete(controller);
            setState(() {
              _mapReady = true;
            });
            log("onMapCreated", name: "GoogleMap");
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(37.5665, 126.9780), // Default position to Seoul
            zoom: 10,
          ),
          markers: _markers,
        ),
        bottomNavigationBar: MyBottomBar(),
      ),
    );
  }
}
