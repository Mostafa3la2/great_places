import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'dart:io';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address =
        await LocationHelper.getPlaceAddress(location.lat!, location.long!);
    final updatedLocation =
        PlaceLocation(lat: location.lat, long: location.long, address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id!,
      "title": newPlace.title!,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location!.lat!,
      "loc_lng": newPlace.location!.long!,
      "address": newPlace.location!.address!
    });
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map((item) => Place(
            id: item["id"] as String,
            title: item["title"] as String,
            image: File(item["image"] as String),
            location: PlaceLocation(
                lat: item["loc_lat"] as double,
                long: item["loc_lng"] as double,
                address: item["address"] as String)))
        .toList();
    notifyListeners();
  }
}
