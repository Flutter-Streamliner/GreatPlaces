import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        location.lattitude, location.longitude);
    final updatedLocation = PlaceLocation(
        lattitude: location.lattitude,
        longitude: location.longitude,
        address: address);
    final newPlace = Place(
        title: title,
        image: image,
        id: DateTime.now().toString(),
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.lattitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
                lattitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address'])))
        .toList();
    notifyListeners();
  }
}
