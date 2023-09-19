import 'dart:convert';

import 'package:favo_places/models/places.dart';
import 'package:favo_places/screens/maps.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key,required this.onselectedlocation});
  final void Function(Placelocation location) onselectedlocation;
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {


 Future <void> _saveddata(double latidue,double longtiude)async{
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latidue,$longtiude&key=AIzaSyBTzszyml7cjzMu1uR15Bqy9i2E_d_XHic');

    final response = await http.get(url);
    final resdata = json.decode(response.body);
    final address = resdata["results"][0]["formatted_address"];
    setState(() {
      pickedlocation =
          Placelocation(longtuide: latidue, latidue: longtiude, address: address);

      ischeked = false;
    });
    widget.onselectedlocation(pickedlocation!);
  }
  Placelocation? pickedlocation;
  var ischeked = false;

  String get locationimage {
    if (pickedlocation == null) {
      return '';
    }
    final lat = pickedlocation!.latidue;
    final long = pickedlocation!.longtuide;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=AIzaSyBTzszyml7cjzMu1uR15Bqy9i2E_d_XHic';
  }

  void _getcurrentlocation() async {
    Location location = Location();
    setState(() {
      ischeked = true;
    });

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      ischeked = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final long = locationData.longitude;
    if (lat == null || long == null) {
      return;
    }
    
    _saveddata(lat, long);
  }

  void _selectedinmap () async{
  final pickedlocations=await  Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx)=> MapScreens()));
 
       if(pickedlocations==null){
        return;
       }
       _saveddata(pickedlocations.latitude, pickedlocations.longitude);
  
  }

  @override
  Widget build(BuildContext context) {
    Widget contentcont = Text(
      'no location found',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (pickedlocation != null) {
      contentcont = Image.network(
        locationimage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    if (ischeked) {
      contentcont = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(.2),
              ),
            ),
            height: 160,
            width: double.infinity,
            alignment: Alignment.center,
            child: contentcont),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getcurrentlocation,
                icon: const Icon(Icons.location_on),
                label: Text(
                  'get current location',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                )),
            TextButton.icon(
              onPressed: 
              _selectedinmap,
                
              icon: const Icon(Icons.map),
              label: Text(
                'select on map',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ],
        )
      ],
    );
  }
}
