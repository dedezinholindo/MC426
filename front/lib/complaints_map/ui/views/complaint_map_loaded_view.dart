import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class ComplaintMapLoadedView extends StatefulWidget {
  final List<LatLng> coordinates;

  const ComplaintMapLoadedView({
    Key? key,
    required this.coordinates,
  }) : super(key: key);

  @override
  ComplaintMapLoadedViewState createState() => ComplaintMapLoadedViewState();
}

class ComplaintMapLoadedViewState extends State<ComplaintMapLoadedView> {
  late final MapController _mapController = MapController();
  late final markers = widget.coordinates.map((e) => _buildMarker("assets/images/pin.svg", e));

  Marker _buildMarker(String pin, LatLng latLong) {
    return Marker(
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
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        keepAlive: true,
        initialZoom: 13,
        maxZoom: 18,
        minZoom: 10,
        initialCameraFit: CameraFit.coordinates(coordinates: widget.coordinates),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          rotate: false,
          alignment: Alignment.topCenter,
          markers: markers.toList(),
        ),
      ],
    );
  }
}
