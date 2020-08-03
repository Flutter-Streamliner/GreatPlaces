import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      print('new location $position prev posotion $_pickedLocation');
      _pickedLocation = position;
      print('picked location = $_pickedLocation');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation != null
                  ? () {
                      Navigator.of(context).pop(_pickedLocation);
                    }
                  : null,
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(
              widget.inititalLocation.lattitude,
              widget.inititalLocation.longitude,
            )),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? null
            : {Marker(markerId: MarkerId("M1"), position: _pickedLocation)},
      ),
    );
  }
}
