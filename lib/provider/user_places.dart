import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:favo_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<Database> getdatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final data = await sql.openDatabase(path.join(dbpath, 'place.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT,image TEXT ,lat REAL,long REAL,address TEXT)');
  }, version: 1);
  return data;
}

class Userplaces extends StateNotifier<List<places>> {
  Userplaces() : super(const []);
 Future <void> loaddatabase() async {
    final db = await getdatabase();
    final data = await db.query(
      'user_places',
    );
   final place= data.map(
      (row) => places(
        id: row['id'] as String,
        title: row['title'] as String,
        selectedphoto: File(row['image'] as String),
        location: Placelocation(
            longtuide: row['long'] as double,
            latidue: row['lat'] as double,
            address: row['address'] as String),
      ),
    ).toList();
    state=place;
    
  }

  void userplaces(String title, File image, Placelocation location) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final imagecopy = await image.copy('${appDir.path}/ $filename');

    final newplaces =
        places(title: title, selectedphoto: imagecopy, location: location);
    final data = await getdatabase();

    data.insert('user_places', {
      'id': newplaces.id,
      'title': newplaces.title,
      'image': newplaces.selectedphoto.path,
      'lat': newplaces.location.latidue,
      'long': newplaces.location.longtuide,
      'address': newplaces.location.address
    });
    state = [newplaces, ...state];
  }
}

final userplacesprovider =
    StateNotifierProvider<Userplaces, List<places>>((ref) => Userplaces());
