import 'package:sqflite/sqflite.dart';

import '../model/ayat.dart';

class DbHelper {
  static DbHelper? _instance;
  static Database? _database;

  DbHelper._internal() {
    _instance = this;
  }

  factory DbHelper() => _instance ?? DbHelper._internal();

  static const String _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
          )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(Ayat ayat) async {
    final db = await database;
    await db?.insert(_tblFavorite, ayat.toJson());
  }

  Future<List<Ayat>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((e) => Ayat.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
    await db!.query(_tblFavorite, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db!.delete(_tblFavorite, where: 'id = ?', whereArgs: [id]);
  }
}