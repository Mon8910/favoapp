import 'package:favo_places/provider/user_places.dart';
import 'package:favo_places/screens/add_places.dart';
import 'package:favo_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

@override
  ConsumerState<PlacesScreen> createState() {
   return _PlacesScreenState();
  }
}
  class _PlacesScreenState extends ConsumerState<PlacesScreen>{
    late Future <void> futuredb;
    @override
  void initState() {
    
    super.initState();
    futuredb= ref.read(userplacesprovider.notifier).loaddatabase() ;
  }
  

  @override
  Widget build(BuildContext context) {
    final userplace = ref.watch(userplacesprovider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddPlaces()));
              },
              icon: const Icon(Icons.add),
            )
          ],
          title: Text(
            'your places',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:FutureBuilder(future:futuredb ,builder: (context, snapshot) => snapshot.connectionState==ConnectionState.waiting ? Center(child: CircularProgressIndicator(),): 
          PlacesLists(place: userplace),
        )));
  }
}

