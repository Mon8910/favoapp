import 'package:favo_places/models/places.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreens extends StatefulWidget {
  const MapScreens(
      {super.key,
      this.location = const Placelocation(
        longtuide: -122.084,
        latidue: 37.442,
        address: '',
      ),
      this.isselecting = true});
  final Placelocation location;
  final bool isselecting;

  @override
  State<MapScreens> createState() {
    return _MapScreens();
  }
}

class _MapScreens extends State<MapScreens> {
  LatLng? pickedlocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isselecting ? 'pick your location ' : 'your location'),
        actions: [
          if (widget.isselecting)
            IconButton(onPressed: () {
              Navigator.of(context).pop(pickedlocation);
            }, icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap:!widget.isselecting ? null: (position) { setState(() {
          pickedlocation=position;
          // 3shan myt8ersh el mark bta3 el map 
          
        }); },
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latidue, widget.location.longtuide),
            zoom: 16),
        markers: (pickedlocation==null && widget.isselecting) ? {} :
        
          // 3shan a5leh marker w y2der a7dd mn 2y mkan 
        {
          Marker(
              markerId: const MarkerId('m1'),
              position:pickedlocation??
                  LatLng(widget.location.latidue, widget.location.longtuide)),
        },
      ),
    );
  }
}
