import 'package:flutter/material.dart';
import 'package:great_places/providers/places.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = "/place-details";

  const PlaceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace = Provider.of<GreatePlaces>(context, listen: false)
        .findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title ?? "NA"),
      ),
      body: Column(
        children: [
          Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location?.address ?? "NA",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => MapScreen(
                          initialLocation: selectedPlace.location!,
                        )));
              },
              child: const Text(
                "View on map!",
                style: TextStyle(color: Colors.cyan),
              ))
        ],
      ),
    );
  }
}
