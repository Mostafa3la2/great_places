import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  // ignore: use_key_in_widget_constructors
  const MapScreen(
      {this.initialLocation = const PlaceLocation(lat: 37.422, long: -122),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map"), actions: [
        if (widget.isSelecting)
          IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check))
      ]),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(widget.initialLocation.lat!, widget.initialLocation.long!),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _pickedLocation != null
                      ? _pickedLocation!
                      : LatLng(widget.initialLocation.lat!,
                          widget.initialLocation.long!),
                )
              },
      ),
    );
  }
}
