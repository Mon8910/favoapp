import 'package:favo_places/models/places.dart';
import 'package:favo_places/screens/maps.dart';
import 'package:flutter/material.dart';

class PlacesDetailsScreens extends StatelessWidget {
  const PlacesDetailsScreens({super.key, required this.place});
  final places place;
  String get locationimage {
    final lat = place.location.latidue;
    final long = place.location.longtuide;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long&key=AIzaSyBTzszyml7cjzMu1uR15Bqy9i2E_d_XHic';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Image.file(
              place.selectedphoto,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => MapScreens(
                                    location: place.location,
                                    isselecting: false,
                                  )));
                        },
                        child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(locationimage))),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 26),
                      child: Text(
                        place.location.address,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
