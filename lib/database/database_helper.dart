import 'package:la_restaurant/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database _database;
  static DBHelper? _dbHelper;
  static String _tableName = 'favorite';

  DBHelper._createObject() {
    _dbHelper = this;
  }

  factory DBHelper() => _dbHelper ?? DBHelper._createObject();

  Future<Database> get database async {
    _database = await initializeDb();
    return _database;
  }

  Future<Database> initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/fav_restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureID TEXT,
        city TEXT,
        rating TEXT
      )''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavRest0(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
  }

  Future<Restaurant?> getFavRestoByID(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    var resto = result.map((restaurant) => Restaurant.fromJson(restaurant));
    return resto.isNotEmpty ? resto.first : null;
  }

  Future<List<Restaurant>> getAllFavResto() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);
    return results
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  Future<void> deleteFavResto(String id) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
