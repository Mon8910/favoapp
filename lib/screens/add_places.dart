import 'dart:io';

import 'package:favo_places/models/places.dart';
import 'package:favo_places/provider/user_places.dart';
import 'package:favo_places/widgets/image_input.dart';
import 'package:favo_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});
  @override
  ConsumerState<AddPlaces> createState() {
    return _AddPlacesState();
  }
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  final textcontrol = TextEditingController();
  File? _selectedimage;
  Placelocation? _selectedlocation;
  void _saveplaces() {
    final titlecontroller = textcontrol.text;
    if (titlecontroller.isEmpty ||
        _selectedimage == null ||
        _selectedlocation == null) {
      return;
    }
    ref
        .read(userplacesprovider.notifier)
        .userplaces(titlecontroller, _selectedimage!, _selectedlocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    textcontrol.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add new places',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLength: 30,
                decoration: InputDecoration(
                  label: Text(
                    'places',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                controller: textcontrol,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 12,
              ),
              ImageInput(
                onpicked: (image) {
                  _selectedimage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              LocationInput(
                onselectedlocation: (location) {
                  _selectedlocation = location;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: _saveplaces,
                label: const Text('add'),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
