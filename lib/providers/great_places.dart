import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    _items.add(Place(
        title: title,
        image: image,
        id: DateTime.now().toString(),
        location: null));
    notifyListeners();
  }
}
