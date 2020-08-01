import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LicationInput extends StatefulWidget {
  @override
  _LicationInputState createState() => _LicationInputState();
}

class _LicationInputState extends State<LicationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locationData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        longitude: locationData.longitude, latitude: locationData.latitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      print(_previewImageUrl);
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MapScreen(
        isSelecting: false,
      ),
    ));
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder:
                      (context, Object object, StackTrace stacktrace) {
                    print(object);
                    print(stacktrace);
                    return Container();
                  },
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
