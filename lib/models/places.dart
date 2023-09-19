import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Placelocation {
 const Placelocation(
      {required this.longtuide, required this.latidue, required this.address});

  final double longtuide;
  final double latidue;
  final String address;
}

class places {
  places(
      {required this.title,
      required this.selectedphoto,
      required this.location
      , String? id
      }
      )
      : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File selectedphoto;
  final Placelocation location;
}
