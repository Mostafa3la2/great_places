import 'package:flutter/material.dart';
import 'package:great_places/providers/places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: Provider.of<GreatePlaces>(context, listen: false)
                .fetchAndSetPlaces(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? const CircularProgressIndicator()
                : Consumer<GreatePlaces>(
                    builder: (ctx, greatPlaces, ch) => greatPlaces
                                .items.length <=
                            0
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title!),
                                  subtitle: Text(
                                      greatPlaces.items[i].location!.address!),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailsScreen.routeName,
                                        arguments: greatPlaces.items[i].id);
                                  },
                                )),
                    child: const Center(
                      child: Text("No places added yet!"),
                    ),
                  ),
          ),
        ));
  }
}
