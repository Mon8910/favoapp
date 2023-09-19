import 'package:favo_places/models/places.dart';
import 'package:favo_places/screens/places_details.dart';
import 'package:flutter/material.dart';

class PlacesLists extends StatelessWidget {
  const PlacesLists({super.key, required this.place});
  final List<places> place;
  @override
  Widget build(BuildContext context) {
    if (place.isEmpty) {
      return Center(
        child: Text(
          'no places find',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return ListView.builder(
      itemCount: place.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundImage: FileImage(place[index].selectedphoto),
        ),
        subtitle: Text(place[index].location.address)
        ,
        title: Text(
          place[index].title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlacesDetailsScreens(
                place: place[index],
              ),
              
            ),
          );
        },
      ),
    );
  }
}
