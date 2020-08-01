import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:great_places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation inititalLocation;
  final bool isSelecting;

  const MapScreen(
      {this.inititalLocation = const PlaceLocation(
        lattitude: 37.422,
        longitude: -122.084,
      ),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: GoogleMap(
        initialPosition: GeoCoord(
          widget.inititalLocation.lattitude,
          widget.inititalLocation.longitude,
        ),
        initialZoom: 16,
      ),
    );
  }
}
