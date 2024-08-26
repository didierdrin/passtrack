import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show MapType;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  final String routeFrom;
  final String routeTo;

  const MapPage({super.key, required this.routeFrom, required this.routeTo});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng? _currentPosition;
  LatLng? _destinationPosition;

  // Hardcoded lat/lng for bus stops

  final Map<String, LatLng> busStops = {
  'Nyabugogo': const LatLng(-1.941167, 30.044028),
  'Muhanga': const LatLng(-2.083528, 29.751806),
  'Ruhango': const LatLng(-2.231944, 29.786861),
  'Nyanza': const LatLng(-2.352222, 29.751333),
  'Huye': const LatLng(-2.590667, 29.743333),
  'Rusizi': const LatLng(-2.488194, 28.918333),
  'Gasarenda': const LatLng(-2.507528, 29.483639),
  'Nyamagabe': const LatLng(-2.473000, 29.581556),
  'Kitabi': const LatLng(-2.528194, 29.417889),
  'Pindura': const LatLng(-2.476000, 29.225278),
  'Kibeho': const LatLng(-2.648222, 29.560222),
  'Munege': const LatLng(-2.836167, 29.558194),
  'Munini': const LatLng(-2.713333, 29.537528),
};

  @override
  void initState() {
    super.initState();
    _setRouteLocations();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _addMarkersAndPolyline();
  }

  void _setRouteLocations() {
    setState(() {
      _currentPosition = _getLocationFromRoute(widget.routeFrom);
      _destinationPosition = _getLocationFromRoute(widget.routeTo);
    });
  }

  LatLng _getLocationFromRoute(String route) {
    switch (route) {
      case 'Nyabugogo':
        return busStops['Nyabugogo']!;
      case 'Muhanga':
        return busStops['Muhanga']!;
      case 'Ruhango':
        return busStops['Ruhango']!;
      case 'Nyanza':
        return busStops['Nyanza']!;
      case 'Huye':
        return busStops['Huye']!;
      default:
        return const LatLng(-1.944, 30.061); // Default location
    }
  }

  void _addMarkersAndPolyline() {
    if (_currentPosition != null && _destinationPosition != null) {
      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('start'),
          position: _currentPosition!,
          infoWindow: InfoWindow(title: widget.routeFrom),
        ));
        _markers.add(Marker(
          markerId: const MarkerId('end'),
          position: _destinationPosition!,
          infoWindow: InfoWindow(title: widget.routeTo),
        ));
        _createPolylines(_currentPosition!, _destinationPosition!);
      });
    }
  }

  void _createPolylines(LatLng start, LatLng end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey:
          'AIzaSyDPWgWxaUeQ_Z3g9kMPeGk9SNPX8GdRENs', // Replace with your API key
      request: PolylineRequest(
          origin: PointLatLng(
              _currentPosition!.latitude, _currentPosition!.longitude),
          destination: PointLatLng(
              _destinationPosition!.latitude, _destinationPosition!.longitude),
          mode: TravelMode.driving),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {
        _polylines.add(Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Bus Route"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentPosition ?? const LatLng(-1.944, 30.061),
          zoom: 14.0,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
