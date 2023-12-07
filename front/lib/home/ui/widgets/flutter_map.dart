import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class CustomFlutterMap extends StatefulWidget {
  final LatLng userCoordinates;

  const CustomFlutterMap({
    Key? key,
    required this.userCoordinates,
  }) : super(key: key);

  @override
  CustomFlutterMapState createState() => CustomFlutterMapState();
}

class CustomFlutterMapState extends State<CustomFlutterMap> {
  late final MapController _mapController = MapController();
  late final user = _buildMarker("assets/images/pin.svg", widget.userCoordinates);

  Marker? _buildMarker(String pin, LatLng latLong) {
    return Marker(
      key: Key(pin),
      width: 36,
      height: 36,
      point: latLong,
      child: SvgPicture.asset(pin),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          keepAlive: true,
          initialZoom: 13,
          maxZoom: 18,
          minZoom: 10,
          initialCameraFit: CameraFit.coordinates(coordinates: [widget.userCoordinates]),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            rotate: false,
            alignment: Alignment.topCenter,
            markers: [
              if (user != null) user!,
            ],
          ),
        ],
      ),
    );
  }
}
