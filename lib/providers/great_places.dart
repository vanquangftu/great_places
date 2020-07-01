import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places/helpers/location_helper.dart';
import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place getPlaceById(String id) {
    return items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, String description, File image,
      PlaceLocation address) async {
    final location = await LocationHelper.getPlaceAdress(
        address.latitude, address.longtitude);
    final updatedLocation = PlaceLocation(
      latitude: address.latitude,
      longtitude: address.longtitude,
      address: location,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      image: image,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'description': newPlace.description,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longtitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlace() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            description: item['description'],
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longtitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
